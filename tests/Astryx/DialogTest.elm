module Astryx.DialogTest exposing (suite)

import Astryx.Dialog as Dialog
import Astryx.Layer as Layer
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Dismiss Layer.Dismissal


suite : Test
suite =
    describe "Astryx.Dialog"
        [ test "is labelled and modal" <|
            \_ ->
                Dialog.view { id = "edit", layers = Layer.open Layer.Modal "edit" Layer.init, title = "Edit", body = [], footer = [], onDismiss = Dismiss, attributes = [] }
                    |> Query.fromHtml
                    |> Query.find [ tag "dialog" ]
                    |> Query.has [ attribute (Attr.attribute "aria-modal" "true"), attribute (Attr.attribute "aria-labelledby" "astryx-dialog-title-edit") ]
        ]
