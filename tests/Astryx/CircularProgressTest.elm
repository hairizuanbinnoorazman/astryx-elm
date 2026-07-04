module Astryx.CircularProgressTest exposing (suite)

import Astryx.CircularProgress as CircularProgress
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, containing, text)


suite : Test
suite =
    describe "Astryx.CircularProgress"
        [ test "clamps progress and exposes an accessible value" <|
            \_ ->
                CircularProgress.view "Upload progress" 120 []
                    |> Query.fromHtml
                    |> Query.has
                        [ attribute (Attr.attribute "role" "progressbar")
                        , attribute (Attr.attribute "aria-label" "Upload progress")
                        , attribute (Attr.attribute "aria-valuenow" "100")
                        , containing [ text "100%" ]
                        ]
        ]
