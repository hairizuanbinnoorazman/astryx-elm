module Astryx.DropdownMenuTest exposing (suite)

import Astryx.DropdownMenu as DropdownMenu
import Astryx.Layer as Layer
import Html exposing (button, text)
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute)


type Msg
    = Dismiss Layer.Dismissal
    | Select


suite : Test
suite =
    describe "Astryx.DropdownMenu"
        [ test "uses native disabled menu items" <|
            \_ ->
                DropdownMenu.view { id = "actions", layers = Layer.open Layer.NonModal "actions" Layer.init, trigger = \attrs -> button attrs [ text "Actions" ], items = [ { label = "Delete", onSelect = Select, disabled = True } ], onDismiss = Dismiss, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ attribute (Attr.attribute "role" "menuitem") ]
                    |> Query.has [ attribute (Attr.disabled True) ]
        ]
