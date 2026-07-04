module Astryx.AlertDialogTest exposing (suite)

import Astryx.AlertDialog as AlertDialog
import Astryx.Layer as Layer
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Select


suite : Test
suite =
    describe "Astryx.AlertDialog"
        [ test "exposes an explicit alert role" <|
            \_ ->
                AlertDialog.view { id = "delete", layers = Layer.open Layer.Modal "delete" Layer.init, title = "Delete?", description = "Permanent", cancelLabel = "Cancel", confirmLabel = "Delete", onCancel = Select, onConfirm = Select, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "dialog" ]
                    |> Query.has [ attribute (Attr.attribute "role" "alertdialog") ]
        ]
