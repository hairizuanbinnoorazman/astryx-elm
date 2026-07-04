module Astryx.Skeleton exposing (text, block)

{-| Non-interactive loading placeholders. Pair them with nearby loading text.

@docs text, block

-}

import Html exposing (Attribute, Html, div)
import Html.Attributes as Attr


{-| Render a text-line placeholder.
-}
text : List (Attribute msg) -> Html msg
text attributes =
    div ([ Attr.class "astryx-skeleton astryx-skeleton--text", Attr.attribute "aria-hidden" "true" ] ++ attributes) []


{-| Render a rectangular placeholder.
-}
block : List (Attribute msg) -> Html msg
block attributes =
    div ([ Attr.class "astryx-skeleton astryx-skeleton--block", Attr.attribute "aria-hidden" "true" ] ++ attributes) []
