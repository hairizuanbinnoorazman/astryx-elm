module Astryx.Stack exposing (Option, view, vertical, horizontal, space, align, wrap)

{-| Flexible one-dimensional layout.

@docs Option, view, vertical, horizontal, space, align, wrap

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, div)
import Html.Attributes as Attr


{-| An opaque stack configuration option.
-}
type Option
    = Direction String
    | Gap String
    | Alignment String
    | Wrapping


{-| Lay children out vertically.
-}
vertical : Option
vertical =
    Direction "column"


{-| Lay children out horizontally.
-}
horizontal : Option
horizontal =
    Direction "row"


{-| Set any valid CSS gap value.
-}
space : String -> Option
space =
    Gap


{-| Set the cross-axis CSS alignment value.
-}
align : String -> Option
align =
    Alignment


{-| Allow children to wrap onto another line.
-}
wrap : Option
wrap =
    Wrapping


{-| Render a stack. Consumer attributes take precedence over generated attributes.
-}
view : List Option -> List (Attribute msg) -> List (Html msg) -> Html msg
view options attributes children =
    div
        (Attributes.merge
            ([ Attr.class "astryx-stack"
             , Attr.style "display" "flex"
             ]
                ++ List.map optionAttribute options
            )
            attributes
        )
        children


optionAttribute : Option -> Attribute msg
optionAttribute option =
    case option of
        Direction value ->
            Attr.style "flex-direction" value

        Gap value ->
            Attr.style "gap" value

        Alignment value ->
            Attr.style "align-items" value

        Wrapping ->
            Attr.style "flex-wrap" "wrap"
