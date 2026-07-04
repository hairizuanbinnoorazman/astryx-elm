module Astryx.Item exposing (Config, view, list)

{-| Structured list content.

@docs Config, view, list

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, div, li, ul)
import Html.Attributes as Attr


{-| The leading, main, and trailing regions of an item.
-}
type alias Config msg =
    { leading : List (Html msg), content : List (Html msg), trailing : List (Html msg), attributes : List (Attribute msg) }


{-| Render one item. Use inside [`list`](#list).
-}
view : Config msg -> Html msg
view config =
    li (Attributes.merge [ Attr.class "astryx-item" ] config.attributes)
        [ div [ Attr.class "astryx-item__leading" ] config.leading
        , div [ Attr.class "astryx-item__content" ] config.content
        , div [ Attr.class "astryx-item__trailing" ] config.trailing
        ]


{-| Render a semantic list of items.
-}
list : List (Attribute msg) -> List (Html msg) -> Html msg
list attributes children =
    ul (Attributes.merge [ Attr.class "astryx-list" ] attributes) children
