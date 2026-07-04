module Astryx.Grid exposing (Option, view, columns, minimumColumnWidth, space)

{-| Responsive two-dimensional layout.

@docs Option, view, columns, minimumColumnWidth, space

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, div)
import Html.Attributes as Attr


{-| An opaque grid configuration option.
-}
type Option
    = Columns Int
    | MinimumColumnWidth String
    | Gap String


{-| Use a fixed number of equal-width columns. Values below one become one.
-}
columns : Int -> Option
columns =
    Columns


{-| Use responsive columns with the given minimum CSS width.
-}
minimumColumnWidth : String -> Option
minimumColumnWidth =
    MinimumColumnWidth


{-| Set any valid CSS gap value.
-}
space : String -> Option
space =
    Gap


{-| Render a grid. Consumer attributes take precedence over generated attributes.
-}
view : List Option -> List (Attribute msg) -> List (Html msg) -> Html msg
view options attributes children =
    div
        (Attributes.merge
            ([ Attr.class "astryx-grid", Attr.style "display" "grid" ]
                ++ List.map optionAttribute options
            )
            attributes
        )
        children


optionAttribute : Option -> Attribute msg
optionAttribute option =
    case option of
        Columns count ->
            Attr.style "grid-template-columns"
                ("repeat(" ++ String.fromInt (max 1 count) ++ ", minmax(0, 1fr))")

        MinimumColumnWidth width ->
            Attr.style "grid-template-columns"
                ("repeat(auto-fit, minmax(min(100%, " ++ width ++ "), 1fr))")

        Gap value ->
            Attr.style "gap" value
