module Astryx.Center exposing (view)

{-| Center content on both axes.

@docs view

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, div)
import Html.Attributes as Attr


{-| Render a flex container that centers its children.
-}
view : List (Attribute msg) -> List (Html msg) -> Html msg
view attributes children =
    div
        (Attributes.merge
            [ Attr.class "astryx-center"
            , Attr.style "display" "flex"
            , Attr.style "align-items" "center"
            , Attr.style "justify-content" "center"
            ]
            attributes
        )
        children
