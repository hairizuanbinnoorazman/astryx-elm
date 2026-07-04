module Astryx.ButtonTest exposing (suite)

import Astryx.Button as Button
import Html exposing (text)
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Clicked


suite : Test
suite =
    describe "Astryx.Button"
        [ test "icon-only buttons accept an accessible name" <|
            \_ ->
                Button.view [ Button.onClick Clicked ] [ Attr.attribute "aria-label" "Save" ] [ text "✓" ]
                    |> Query.fromHtml
                    |> Query.has [ tag "button", attribute (Attr.attribute "aria-label" "Save") ]
        ]
