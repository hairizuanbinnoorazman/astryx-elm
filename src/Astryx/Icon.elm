module Astryx.Icon exposing (Icon, decorative, labelled, view)

{-| A contract for consumer-provided Elm-native icon markup.

@docs Icon, decorative, labelled, view

-}

import Html exposing (Attribute, Html, span)
import Html.Attributes as Attr


{-| An opaque icon with explicit accessible semantics.
-}
type Icon msg
    = Icon (List (Attribute msg)) (Html msg)


{-| Create an icon hidden from assistive technology.
-}
decorative : Html msg -> Icon msg
decorative content =
    Icon [ Attr.attribute "aria-hidden" "true" ] content


{-| Create an icon with an accessible name.
-}
labelled : String -> Html msg -> Icon msg
labelled label content =
    Icon [ Attr.attribute "role" "img", Attr.attribute "aria-label" label ] content


{-| Render an icon.
-}
view : Icon msg -> Html msg
view (Icon attributes content) =
    span (Attr.class "astryx-icon" :: attributes) [ content ]
