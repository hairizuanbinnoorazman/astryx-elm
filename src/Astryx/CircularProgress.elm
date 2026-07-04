module Astryx.CircularProgress exposing (view)

{-| A compact circular determinate progress indicator.

Use this when the available space does not suit a horizontal progress element.
The visible percentage is also exposed through native progressbar semantics.

@docs view

-}

import Html exposing (Attribute, Html, div, span, text)
import Html.Attributes as Attr


{-| Render progress from zero to one hundred. Values outside that range are
clamped. The label is used as the progressbar's accessible name.
-}
view : String -> Float -> List (Attribute msg) -> Html msg
view label value attributes =
    let
        progress =
            clamp 0 100 value

        percentage =
            String.fromInt (round progress) ++ "%"
    in
    div
        ([ Attr.class "astryx-circular-progress"
         , Attr.attribute "role" "progressbar"
         , Attr.attribute "aria-label" label
         , Attr.attribute "aria-valuemin" "0"
         , Attr.attribute "aria-valuemax" "100"
         , Attr.attribute "aria-valuenow" (String.fromFloat progress)
         , Attr.style "--astryx-progress-value" (String.fromFloat progress ++ "%")
         ]
            ++ attributes
        )
        [ span [ Attr.class "astryx-circular-progress__value" ] [ text percentage ] ]
