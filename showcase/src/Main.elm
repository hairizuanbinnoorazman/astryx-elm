module Main exposing (main)

import Astryx.Accessibility as Accessibility
import Astryx.Badge as Badge
import Astryx.Banner as Banner
import Astryx.Button as Button
import Astryx.Card as Card
import Astryx.Center as Center
import Astryx.Form.Checkbox as Checkbox
import Astryx.Form.Field as Field
import Astryx.Form.Layout as FormLayout
import Astryx.Form.Select as Select
import Astryx.Form.TextArea as TextArea
import Astryx.Form.TextInput as TextInput
import Astryx.Grid as Grid
import Astryx.Heading as Heading
import Astryx.Icon as Icon
import Astryx.Progress as Progress
import Astryx.Size as Size
import Astryx.Stack as Stack
import Astryx.Status as Status
import Astryx.StatusDot as StatusDot
import Astryx.Text as Text
import Astryx.Theme as Theme
import Browser
import Html exposing (Html, button, code, nav, section, span, text)
import Html.Attributes as Attr
import Html.Events as Events


type alias Model =
    { dark : Bool, name : String, email : String, bio : String, role : String, alerts : Bool, saved : Bool }


type Msg
    = ToggleTheme
    | SetName String
    | SetEmail String
    | SetBio String
    | SetRole String
    | SetAlerts Bool
    | Save


main : Program () Model Msg
main =
    Browser.sandbox { init = { dark = False, name = "", email = "", bio = "", role = "", alerts = True, saved = False }, update = update, view = view }


update : Msg -> Model -> Model
update message model =
    case message of
        ToggleTheme ->
            { model | dark = not model.dark }

        SetName value ->
            { model | name = value, saved = False }

        SetEmail value ->
            { model | email = value, saved = False }

        SetBio value ->
            { model | bio = value, saved = False }

        SetRole value ->
            { model | role = value, saved = False }

        SetAlerts value ->
            { model | alerts = value, saved = False }

        Save ->
            { model | saved = True }


view : Model -> Html Msg
view model =
    Theme.root
        (if model.dark then
            Theme.dark

         else
            Theme.light
        )
        [ Attr.style "min-height" "100vh", Attr.style "padding" "var(--astryx-space-lg)" ]
        [ Theme.stylesheet
        , Stack.view [ Stack.space "var(--astryx-space-lg)" ]
            []
            [ Heading.view Heading.h1 [] [ text "Astryx components" ]
            , nav [] [ text "Foundation · Controls · Forms · Status · Feedback" ]
            , button [ Events.onClick ToggleTheme ] [ text "Toggle light/dark theme" ]
            , demo "Theme" [ Text.view Text.normal [] [ text "Semantic custom properties are inherited." ] ]
            , demo "Accessibility"
                [ Accessibility.liveRegion [] [ text "Polite live region" ]
                , Accessibility.visuallyHidden [ text "Screen-reader-only content" ]
                ]
            , demo "Size and status"
                [ code [] [ text (Size.toClass Size.Medium ++ " / " ++ Status.toString Status.Success) ] ]
            , demo "Stack"
                [ Stack.view [ Stack.horizontal, Stack.space "1rem", Stack.wrap ] [] [ tile "One", tile "Two", tile "Three" ] ]
            , demo "Grid"
                [ Grid.view [ Grid.minimumColumnWidth "10rem", Grid.space "1rem" ] [] [ tile "One", tile "Two", tile "Three" ] ]
            , demo "Center"
                [ Center.view [ Attr.style "min-height" "6rem", Attr.style "border" "1px solid var(--astryx-border)" ] [ text "Centered" ] ]
            , demo "Typography"
                [ Heading.view Heading.h3 [] [ text "Heading" ], Text.view Text.muted [] [ text "Muted supporting text" ] ]
            , demo "Icon" [ Icon.view (Icon.labelled "Favorite" (span [] [ text "★" ])) ]
            , validatedForm model
            , settingsPage model
            ]
        ]


validatedForm : Model -> Html Msg
validatedForm model =
    let
        nameError =
            if String.trim model.name == "" then
                Just "Enter your name."

            else
                Nothing

        emailError =
            if String.contains "@" model.email then
                Nothing

            else
                Just "Enter a valid email address."
    in
    demo "Validated profile form"
        ((if model.saved then
            [ Banner.view { status = Status.Success, title = "Profile saved", body = [ text "Your changes are available now." ], dismiss = Nothing, attributes = [] } ]

          else
            []
         )
            ++ [ FormLayout.vertical []
                    [ Field.view { key = "name", label = "Name", description = Nothing, error = nameError, required = True, control = \wiring -> TextInput.view { wiring = wiring, value = model.name, onInput = SetName, inputType = TextInput.Text, disabled = False, readOnly = False, attributes = [] } }
                    , Field.view { key = "email", label = "Email", description = Just "Used for account notifications.", error = emailError, required = True, control = \wiring -> TextInput.view { wiring = wiring, value = model.email, onInput = SetEmail, inputType = TextInput.Email, disabled = False, readOnly = False, attributes = [] } }
                    , Field.view { key = "bio", label = "Biography", description = Just "A short public introduction.", error = Nothing, required = False, control = \wiring -> TextArea.view { wiring = wiring, value = model.bio, onInput = SetBio, rows = 4, resize = TextArea.Vertical, disabled = False, readOnly = False, attributes = [] } }
                    , Field.view
                        { key = "role"
                        , label = "Role"
                        , description = Nothing
                        , error =
                            if model.role == "" then
                                Just "Choose a role."

                            else
                                Nothing
                        , required = True
                        , control = \wiring -> Select.view { wiring = wiring, value = model.role, placeholder = Just "Choose a role", options = [ { value = "admin", label = "Administrator", disabled = False }, { value = "member", label = "Member", disabled = False } ], disabled = False, onChange = SetRole, attributes = [] }
                        }
                    , Checkbox.view { id = "alerts", label = "Email me security alerts", checked = model.alerts, indeterminate = False, disabled = False, onChange = SetAlerts, attributes = [] }
                    , Button.view [ Button.primary, Button.onClick Save, Button.disabled (nameError /= Nothing || emailError /= Nothing || model.role == "") ] [] [ text "Save profile" ]
                    ]
               ]
        )


settingsPage : Model -> Html Msg
settingsPage model =
    demo "Settings detail"
        [ Card.view
            { header = [ Heading.view Heading.h3 [] [ text "Workspace status" ] ]
            , body =
                [ Stack.view [ Stack.space "0.75rem" ]
                    []
                    [ StatusDot.view Status.Success "Service operational" []
                    , Badge.view Status.Info [] [ text "Pro plan" ]
                    , Text.view Text.muted
                        []
                        [ text
                            (if model.alerts then
                                "Security alerts enabled"

                             else
                                "Security alerts disabled"
                            )
                        ]
                    , Progress.view "Storage used" 42 []
                    ]
                ]
            , footer = [ Button.view [ Button.secondary, Button.onClick ToggleTheme ] [] [ text "Change appearance" ] ]
            , attributes = []
            }
        ]


demo : String -> List (Html msg) -> Html msg
demo title content =
    section [ Attr.id (Accessibility.id "section" title) ]
        [ Heading.view Heading.h2 [] [ text title ]
        , Stack.view [ Stack.space "0.75rem" ] [ Attr.style "margin-top" "0.75rem" ] content
        ]


tile : String -> Html msg
tile label =
    Center.view
        [ Attr.style "padding" "1rem"
        , Attr.style "background" "var(--astryx-surface)"
        , Attr.style "border" "1px solid var(--astryx-border)"
        , Attr.style "border-radius" "var(--astryx-radius-md)"
        ]
        [ text label ]
