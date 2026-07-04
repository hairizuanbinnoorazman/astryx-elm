module Astryx.Form.FieldTest exposing (suite)

import Astryx.Form.Field as Field
import Astryx.Form.TextInput as TextInput
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Changed String


suite : Test
suite =
    describe "Astryx.Form.Field"
        [ test "associates labels, descriptions, and errors" <|
            \_ ->
                Field.view
                    { key = "email"
                    , label = "Email"
                    , description = Just "Work address"
                    , error = Just "Invalid address"
                    , required = True
                    , control = \wiring -> TextInput.view { wiring = wiring, value = "", onInput = Changed, inputType = TextInput.Email, disabled = False, readOnly = False, attributes = [] }
                    }
                    |> Query.fromHtml
                    |> Query.find [ tag "input" ]
                    |> Query.has [ attribute (Attr.attribute "aria-labelledby" "astryx-label-email"), attribute (Attr.attribute "aria-describedby" "astryx-description-email astryx-error-email"), attribute (Attr.attribute "aria-invalid" "true") ]
        ]
