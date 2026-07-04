module Astryx.Badge exposing (view)

{-| Compact textual status labels.

@docs view

-}

import Astryx.Internal.Attributes as Attributes
import Astryx.Status as Status exposing (Status)
import Html exposing (Attribute, Html, span)
import Html.Attributes as Attr


{-| Render a status badge whose children state its meaning.
-}
view : Status -> List (Attribute msg) -> List (Html msg) -> Html msg
view status attributes children =
    span (Attributes.merge [ Attr.class "astryx-badge", Attr.class ("astryx-status--" ++ Status.toString status) ] attributes) children
