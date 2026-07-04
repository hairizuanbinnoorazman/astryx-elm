module Astryx.Divider exposing (decorative, semantic)

{-| Horizontal separators.

@docs decorative, semantic

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, div, hr)
import Html.Attributes as Attr


{-| Render a semantic horizontal rule.
-}
semantic : List (Attribute msg) -> Html msg
semantic attributes =
    hr (Attributes.merge [ Attr.class "astryx-divider" ] attributes) []


{-| Render a separator hidden from assistive technology.
-}
decorative : List (Attribute msg) -> Html msg
decorative attributes =
    div (Attributes.merge [ Attr.class "astryx-divider", Attr.attribute "aria-hidden" "true" ] attributes) []
