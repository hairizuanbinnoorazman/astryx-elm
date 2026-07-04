module Astryx.Dialog exposing (Config, view)

{-| Accessible modal dialog rendering on the shared layer stack.

@docs Config, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Layer as Layer
import Html exposing (Attribute, Html, button, div, h2, text)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode


{-| Dialog content and dismissal callback.
-}
type alias Config msg =
    { id : Layer.Id
    , layers : Layer.State
    , title : String
    , body : List (Html msg)
    , footer : List (Html msg)
    , onDismiss : Layer.Dismissal -> msg
    , attributes : List (Attribute msg)
    }


{-| Render nothing when closed. The first close button receives focus on entry.
-}
view : Config msg -> Html msg
view config =
    if Layer.isOpen config.id config.layers then
        let
            titleId =
                Accessibility.id "dialog-title" config.id

            z =
                Layer.zIndex config.id config.layers |> Maybe.withDefault 1000
        in
        div
            [ Attr.id (Accessibility.id "backdrop" config.id)
            , Attr.class "astryx-layer-backdrop"
            , Attr.style "z-index" (String.fromInt z)
            , Events.on "click" (outsideDecoder (Accessibility.id "backdrop" config.id) (config.onDismiss Layer.OutsideClick))
            , Events.on "keydown" (escapeDecoder config.onDismiss)
            ]
            [ Html.node "dialog"
                ([ Attr.class "astryx-dialog"
                 , Attr.attribute "open" ""
                 , Attr.attribute "aria-modal" "true"
                 , Attr.attribute "aria-labelledby" titleId
                 ]
                    ++ config.attributes
                )
                [ div [ Attr.class "astryx-dialog__header" ]
                    [ h2 [ Attr.id titleId ] [ text config.title ]
                    , button [ Attr.type_ "button", Attr.attribute "aria-label" "Close", Attr.autofocus True, Events.onClick (config.onDismiss Layer.Action) ] [ text "×" ]
                    ]
                , div [ Attr.class "astryx-dialog__body" ] config.body
                , div [ Attr.class "astryx-dialog__footer" ] config.footer
                ]
            ]

    else
        text ""


escapeDecoder : (Layer.Dismissal -> msg) -> Decode.Decoder msg
escapeDecoder toMsg =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Escape" then
                    Decode.succeed (toMsg Layer.Escape)

                else
                    Decode.fail "Not Escape"
            )


outsideDecoder : String -> msg -> Decode.Decoder msg
outsideDecoder backdropId message =
    Decode.map2 Tuple.pair (Decode.at [ "target", "id" ] Decode.string) (Decode.at [ "currentTarget", "id" ] Decode.string)
        |> Decode.andThen
            (\( target, current ) ->
                if target == backdropId && current == backdropId then
                    Decode.succeed message

                else
                    Decode.fail "Inside dialog"
            )
