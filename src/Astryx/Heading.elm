module Astryx.Heading exposing (Level, h1, h2, h3, h4, h5, h6, view)

{-| Semantic headings with consistent visual treatment.

@docs Level, h1, h2, h3, h4, h5, h6, view

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, node)
import Html.Attributes as Attr


{-| An opaque HTML heading level.
-}
type Level
    = Level Int


{-| Heading level one.
-}
h1 : Level
h1 =
    Level 1


{-| Heading level two.
-}
h2 : Level
h2 =
    Level 2


{-| Heading level three.
-}
h3 : Level
h3 =
    Level 3


{-| Heading level four.
-}
h4 : Level
h4 =
    Level 4


{-| Heading level five.
-}
h5 : Level
h5 =
    Level 5


{-| Heading level six.
-}
h6 : Level
h6 =
    Level 6


{-| Render the corresponding semantic heading element.
-}
view : Level -> List (Attribute msg) -> List (Html msg) -> Html msg
view (Level level) attributes children =
    node ("h" ++ String.fromInt level)
        (Attributes.merge
            [ Attr.class "astryx-heading"
            , Attr.style "margin" "0"
            , Attr.style "line-height" "1.2"
            , Attr.style "font-size" (fontSize level)
            ]
            attributes
        )
        children


fontSize : Int -> String
fontSize level =
    case level of
        1 ->
            "2.25rem"

        2 ->
            "1.875rem"

        3 ->
            "1.5rem"

        4 ->
            "1.25rem"

        5 ->
            "1rem"

        _ ->
            "0.875rem"
