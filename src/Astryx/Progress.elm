module Astryx.Progress exposing (view, indeterminate)

{-| Determinate and indeterminate progress indicators.

@docs view, indeterminate

-}

import Html exposing (Attribute, Html, div)
import Html.Attributes as Attr


{-| Render progress from zero to one hundred.
-}
view : String -> Float -> List (Attribute msg) -> Html msg
view label value attributes =
    Html.progress ([ Attr.class "astryx-progress", Attr.attribute "aria-label" label, Attr.value (String.fromFloat (clamp 0 100 value)), Attr.max "100" ] ++ attributes) []


{-| Render progress when completion cannot be calculated.
-}
indeterminate : String -> List (Attribute msg) -> Html msg
indeterminate label attributes =
    div ([ Attr.class "astryx-progress", Attr.class "astryx-progress--indeterminate", Attr.attribute "role" "progressbar", Attr.attribute "aria-label" label ] ++ attributes) []
