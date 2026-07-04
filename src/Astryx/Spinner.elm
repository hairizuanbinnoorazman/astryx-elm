module Astryx.Spinner exposing (view)

{-| Accessible loading spinner.

@docs view

-}

import Html exposing (Attribute, Html, span)
import Html.Attributes as Attr


{-| Render a spinner with an accessible loading label.
-}
view : String -> List (Attribute msg) -> Html msg
view label attributes =
    span ([ Attr.class "astryx-spinner", Attr.attribute "role" "status", Attr.attribute "aria-label" label ] ++ attributes) []
