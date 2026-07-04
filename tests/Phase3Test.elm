module Phase3Test exposing (suite)

import Astryx.Button as Button
import Astryx.Form.Field as Field
import Astryx.Form.TextInput as TextInput
import Astryx.Status as Status
import Astryx.StatusDot as StatusDot
import Html exposing (text)
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, tag)


type Msg
    = Clicked
    | Changed String


suite : Test
suite =
    describe "Phase 3 accessibility"
        [ test "icon-only buttons accept an accessible name" <|
            \_ ->
                Button.view [ Button.onClick Clicked ] [ Attr.attribute "aria-label" "Save" ] [ text "✓" ]
                    |> Query.fromHtml
                    |> Query.has [ tag "button", attribute (Attr.attribute "aria-label" "Save") ]
        , test "fields associate labels, descriptions, and errors" <|
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
        , test "status dots require an accessible name" <|
            \_ ->
                StatusDot.view Status.Success "Online" []
                    |> Query.fromHtml
                    |> Query.has [ attribute (Attr.attribute "role" "status"), attribute (Attr.attribute "aria-label" "Online") ]
        ]
