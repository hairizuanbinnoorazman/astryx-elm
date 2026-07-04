module Astryx.PaginationTest exposing (suite)

import Astryx.Pagination as Pagination
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Page Int


suite : Test
suite =
    describe "Astryx.Pagination"
        [ test "disables previous on first page" <|
            \_ ->
                Pagination.view { page = 1, pageCount = 3, onChange = Page, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "button", attribute (Attr.attribute "aria-label" "Previous page") ]
                    |> Query.has [ attribute (Attr.disabled True) ]
        ]
