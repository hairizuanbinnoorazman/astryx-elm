module Astryx.Popover exposing (Config, view)

{-| Non-modal popover on the shared layer stack.

@docs Config, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Layer as Layer
import Html exposing (Attribute, Html, div, text)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode


{-| Popover trigger, panel, and dismissal callback.
-}
type alias Config msg =
    { id : Layer.Id, layers : Layer.State, trigger : List (Attribute msg) -> Html msg, content : List (Html msg), onDismiss : Layer.Dismissal -> msg, attributes : List (Attribute msg) }


{-| Render a trigger and its open panel.
-}
view : Config msg -> Html msg
view config =
    let
        panelId =
            Accessibility.id "popover" config.id

        open =
            Layer.isOpen config.id config.layers
    in
    div ([ Attr.class "astryx-overlay-anchor", Events.on "keydown" (escape config.onDismiss) ] ++ config.attributes)
        [ config.trigger [ Attr.attribute "aria-expanded" (bool open), Attr.attribute "aria-controls" panelId, Attr.attribute "aria-haspopup" "dialog" ]
        , if open then
            div [ Attr.id panelId, Attr.class "astryx-popover", Attr.attribute "role" "dialog", Attr.style "z-index" (z config) ] config.content

          else
            text ""
        ]


bool : Bool -> String
bool value =
    if value then
        "true"

    else
        "false"


z : Config msg -> String
z config =
    Layer.zIndex config.id config.layers |> Maybe.withDefault 1000 |> String.fromInt


escape : (Layer.Dismissal -> msg) -> Decode.Decoder msg
escape toMsg =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Escape" then
                    Decode.succeed (toMsg Layer.Escape)

                else
                    Decode.fail "Not Escape"
            )
