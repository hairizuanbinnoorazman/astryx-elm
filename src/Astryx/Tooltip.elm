module Astryx.Tooltip exposing (Config, view)

{-| A labelled trigger and non-interactive tooltip.

@docs Config, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Layer as Layer
import Html exposing (Attribute, Html, div, text)
import Html.Attributes as Attr


{-| Tooltip trigger and content. Applications open it from trigger hover/focus events.
-}
type alias Config msg =
    { id : Layer.Id, layers : Layer.State, trigger : List (Attribute msg) -> Html msg, content : String, attributes : List (Attribute msg) }


{-| Render the trigger and, while open, its tooltip.
-}
view : Config msg -> Html msg
view config =
    let
        tooltipId =
            Accessibility.id "tooltip" config.id

        visible =
            Layer.isOpen config.id config.layers
    in
    div ([ Attr.class "astryx-overlay-anchor" ] ++ config.attributes)
        [ config.trigger [ Attr.attribute "aria-describedby" tooltipId ]
        , if visible then
            div [ Attr.id tooltipId, Attr.attribute "role" "tooltip", Attr.class "astryx-tooltip", layerStyle config.id config.layers ] [ text config.content ]

          else
            text ""
        ]


layerStyle : Layer.Id -> Layer.State -> Attribute msg
layerStyle id state =
    Attr.style "z-index" (Layer.zIndex id state |> Maybe.withDefault 1000 |> String.fromInt)
