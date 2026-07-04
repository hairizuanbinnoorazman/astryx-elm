module Astryx.Table exposing (Column, Config, view)

{-| Responsive data tables.

@docs Column, Config, view

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, caption, div, table, tbody, td, text, th, thead, tr)
import Html.Attributes as Attr


{-| A column heading and cell renderer.
-}
type alias Column row msg =
    { heading : String, view : row -> Html msg }


{-| Table data and accessibility configuration.
-}
type alias Config row msg =
    { caption : String, columns : List (Column row msg), rows : List row, rowKey : row -> String, attributes : List (Attribute msg) }


{-| Render a table in a horizontally scrollable region.
-}
view : Config row msg -> Html msg
view config =
    div [ Attr.class "astryx-table-region", Attr.tabindex 0, Attr.attribute "role" "region", Attr.attribute "aria-label" config.caption ]
        [ table (Attributes.merge [ Attr.class "astryx-table" ] config.attributes)
            [ caption [ Attr.class "astryx-visually-hidden" ] [ text config.caption ]
            , thead [] [ tr [] (List.map (\column -> th [ Attr.scope "col" ] [ text column.heading ]) config.columns) ]
            , tbody [] (List.map (rowView config) config.rows)
            ]
        ]


rowView : Config row msg -> row -> Html msg
rowView config row =
    tr [ Attr.attribute "data-row-key" (config.rowKey row) ] (List.map (\column -> td [] [ column.view row ]) config.columns)
