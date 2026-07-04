module Astryx.StatusDotTest exposing (suite)

import Astryx.Status as Status
import Astryx.StatusDot as StatusDot
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute)


suite : Test
suite =
    describe "Astryx.StatusDot"
        [ test "requires an accessible name" <|
            \_ ->
                StatusDot.view Status.Success "Online" []
                    |> Query.fromHtml
                    |> Query.has [ attribute (Attr.attribute "role" "status"), attribute (Attr.attribute "aria-label" "Online") ]
        ]
