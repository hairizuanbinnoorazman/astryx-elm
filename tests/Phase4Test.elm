module Phase4Test exposing (suite)

import Astryx.Collapsible as Collapsible
import Astryx.Pagination as Pagination
import Astryx.Table as Table
import Astryx.Tabs as Tabs
import Astryx.Toast as Toast
import Expect
import Html
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag, text)


type Msg
    = Selected String
    | Page Int
    | CollapsibleMsg Collapsible.Msg
    | ToastMsg Toast.Msg


suite : Test
suite =
    describe "Phase 4 structure"
        [ test "table exposes a captioned scroll region" <|
            \_ ->
                Table.view { caption = "People", columns = [ { heading = "Name", view = .name >> Html.text } ], rows = [ { name = "Ada", id = "1" } ], rowKey = .id, attributes = [] }
                    |> Query.fromHtml
                    |> Query.has [ tag "table" ]
        , test "tabs connect the selected tab and panel" <|
            \_ ->
                Tabs.view { key = "account", selected = "profile", tabs = [ { id = "profile", label = "Profile", panel = [ Html.text "Panel" ], disabled = False } ], onSelect = Selected, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "button" ]
                    |> Query.has [ attribute (Attr.attribute "aria-selected" "true"), attribute (Attr.attribute "aria-controls" "astryx-tabpanel-account-profile") ]
        , test "pagination disables previous on first page" <|
            \_ ->
                Pagination.view { page = 1, pageCount = 3, onChange = Page, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "button", attribute (Attr.attribute "aria-label" "Previous page") ]
                    |> Query.has [ attribute (Attr.disabled True) ]
        , test "collapsible transitions are explicit" <|
            \_ ->
                Collapsible.init False |> Collapsible.update Collapsible.Toggle |> Collapsible.isOpen |> Expect.equal True
        , test "toast dismiss removes the notification" <|
            \_ ->
                Toast.init |> Toast.add { id = "saved", title = "Saved", message = "Done" } |> Toast.dismiss "saved" |> Toast.view ToastMsg [] |> Query.fromHtml |> Query.hasNot [ text "Saved" ]
        ]
