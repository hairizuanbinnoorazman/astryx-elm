module Astryx.TabsTest exposing (suite)

import Astryx.Tabs as Tabs
import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Selected String


suite : Test
suite =
    describe "Astryx.Tabs"
        [ test "connects the selected tab and panel" <|
            \_ ->
                Tabs.view { key = "account", selected = "profile", tabs = [ { id = "profile", label = "Profile", panel = [ Html.text "Panel" ], disabled = False } ], onSelect = Selected, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "button" ]
                    |> Query.has [ attribute (Attr.attribute "aria-selected" "true"), attribute (Attr.attribute "aria-controls" "astryx-tabpanel-account-profile") ]
        ]
