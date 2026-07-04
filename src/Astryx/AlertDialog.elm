module Astryx.AlertDialog exposing (Config, view)

{-| A modal alert dialog requiring an explicit decision.

@docs Config, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Layer as Layer
import Html exposing (Attribute, Html, button, div, h2, p, text)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode


{-| Alert dialog content. Outside clicks intentionally do not dismiss it.
-}
type alias Config msg =
    { id : Layer.Id, layers : Layer.State, title : String, description : String, cancelLabel : String, confirmLabel : String, onCancel : msg, onConfirm : msg, attributes : List (Attribute msg) }


{-| Render an open alert dialog. Escape maps to cancellation.
-}
view : Config msg -> Html msg
view config =
    if Layer.isOpen config.id config.layers then
        let
            titleId =
                Accessibility.id "alert-title" config.id

            descriptionId =
                Accessibility.id "alert-description" config.id

            z =
                Layer.zIndex config.id config.layers |> Maybe.withDefault 1000
        in
        div [ Attr.class "astryx-layer-backdrop", Attr.style "z-index" (String.fromInt z), Events.on "keydown" (escape config.onCancel) ]
            [ Html.node "dialog"
                ([ Attr.class "astryx-dialog", Attr.attribute "open" "", Attr.attribute "role" "alertdialog", Attr.attribute "aria-modal" "true", Attr.attribute "aria-labelledby" titleId, Attr.attribute "aria-describedby" descriptionId ] ++ config.attributes)
                [ div [ Attr.class "astryx-dialog__header" ] [ h2 [ Attr.id titleId ] [ text config.title ] ]
                , p [ Attr.id descriptionId, Attr.class "astryx-dialog__body" ] [ text config.description ]
                , div [ Attr.class "astryx-dialog__footer" ]
                    [ button [ Attr.type_ "button", Attr.autofocus True, Events.onClick config.onCancel ] [ text config.cancelLabel ]
                    , button [ Attr.type_ "button", Events.onClick config.onConfirm ] [ text config.confirmLabel ]
                    ]
                ]
            ]

    else
        text ""


escape : msg -> Decode.Decoder msg
escape message =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Escape" then
                    Decode.succeed message

                else
                    Decode.fail "Not Escape"
            )
