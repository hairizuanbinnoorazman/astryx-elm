module Astryx.TableTest exposing (suite)

import Astryx.Table as Table
import Html
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag)


suite : Test
suite =
    describe "Astryx.Table"
        [ test "exposes a captioned scroll region" <|
            \_ ->
                Table.view { caption = "People", columns = [ { heading = "Name", view = .name >> Html.text } ], rows = [ { name = "Ada", id = "1" } ], rowKey = .id, attributes = [] }
                    |> Query.fromHtml
                    |> Query.has [ tag "table" ]
        ]
