module Phase5Test exposing (suite)

import Astryx.AlertDialog as AlertDialog
import Astryx.Dialog as Dialog
import Astryx.DropdownMenu as DropdownMenu
import Astryx.Layer as Layer
import Expect
import Html exposing (button, text)
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Dismiss Layer.Dismissal
    | Select


suite : Test
suite =
    describe "Phase 5 overlay engine"
        [ test "layers have stable ordering and nested close semantics" <|
            \_ ->
                Layer.init
                    |> Layer.open Layer.Modal "dialog"
                    |> Layer.open Layer.NonModal "menu"
                    |> Layer.close "dialog"
                    |> Layer.layers
                    |> Expect.equal []
        , test "only the top layer accepts dismissal" <|
            \_ ->
                let
                    state =
                        Layer.init |> Layer.open Layer.Modal "dialog" |> Layer.open Layer.NonModal "menu"
                in
                Layer.dismiss Layer.Escape "dialog" state |> Layer.layers |> Expect.equal [ "dialog", "menu" ]
        , test "dialog is labelled and modal" <|
            \_ ->
                Dialog.view { id = "edit", layers = Layer.open Layer.Modal "edit" Layer.init, title = "Edit", body = [], footer = [], onDismiss = Dismiss, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "dialog" ]
                    |> Query.has [ attribute (Attr.attribute "aria-modal" "true"), attribute (Attr.attribute "aria-labelledby" "astryx-dialog-title-edit") ]
        , test "alert dialog exposes an explicit alert role" <|
            \_ ->
                AlertDialog.view { id = "delete", layers = Layer.open Layer.Modal "delete" Layer.init, title = "Delete?", description = "Permanent", cancelLabel = "Cancel", confirmLabel = "Delete", onCancel = Select, onConfirm = Select, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "dialog" ]
                    |> Query.has [ attribute (Attr.attribute "role" "alertdialog") ]
        , test "dropdown menu uses native disabled menu items" <|
            \_ ->
                DropdownMenu.view { id = "actions", layers = Layer.open Layer.NonModal "actions" Layer.init, trigger = \attrs -> button attrs [ text "Actions" ], items = [ { label = "Delete", onSelect = Select, disabled = True } ], onDismiss = Dismiss, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ attribute (Attr.attribute "role" "menuitem") ]
                    |> Query.has [ attribute (Attr.disabled True) ]
        ]
