module Main exposing (main)

import Astryx.Accessibility as Accessibility
import Astryx.AlertDialog as AlertDialog
import Astryx.AppShell as AppShell
import Astryx.Badge as Badge
import Astryx.Banner as Banner
import Astryx.Breadcrumbs as Breadcrumbs
import Astryx.Button as Button
import Astryx.Calendar as Calendar
import Astryx.Card as Card
import Astryx.Carousel as Carousel
import Astryx.Center as Center
import Astryx.Collapsible as Collapsible
import Astryx.ContextMenu as ContextMenu
import Astryx.Dialog as Dialog
import Astryx.DropdownMenu as DropdownMenu
import Astryx.EmptyState as EmptyState
import Astryx.Form.Checkbox as Checkbox
import Astryx.Form.Field as Field
import Astryx.Form.Layout as FormLayout
import Astryx.Form.Select as Select
import Astryx.Form.TextArea as TextArea
import Astryx.Form.TextInput as TextInput
import Astryx.Grid as Grid
import Astryx.Heading as Heading
import Astryx.Icon as Icon
import Astryx.Item as Item
import Astryx.Layer as Layer
import Astryx.Pagination as Pagination
import Astryx.Popover as Popover
import Astryx.Progress as Progress
import Astryx.SegmentedControl as SegmentedControl
import Astryx.SideNav as SideNav
import Astryx.Size as Size
import Astryx.Skeleton as Skeleton
import Astryx.Stack as Stack
import Astryx.Status as Status
import Astryx.StatusDot as StatusDot
import Astryx.Table as Table
import Astryx.Tabs as Tabs
import Astryx.Text as Text
import Astryx.Theme as Theme
import Astryx.Toast as Toast
import Astryx.Tooltip as Tooltip
import Astryx.TopNav as TopNav
import Astryx.Typeahead as Typeahead
import Browser
import Html exposing (Html, button, code, nav, section, span, text)
import Html.Attributes as Attr
import Html.Events as Events


type alias Model =
    { dark : Bool, name : String, email : String, bio : String, role : String, alerts : Bool, saved : Bool, tab : String, page : Int, details : Collapsible.State, toasts : Toast.State, layers : Layer.State }


type Msg
    = ToggleTheme
    | SetName String
    | SetEmail String
    | SetBio String
    | SetRole String
    | SetAlerts Bool
    | Save
    | SelectTab String
    | SetPage Int
    | DetailsMsg Collapsible.Msg
    | ToastMsg Toast.Msg
    | OpenLayer Layer.Kind Layer.Id
    | DismissLayer Layer.Id Layer.Dismissal
    | LayerAction Layer.Id


main : Program () Model Msg
main =
    Browser.sandbox { init = { dark = False, name = "", email = "", bio = "", role = "", alerts = True, saved = False, tab = "people", page = 1, details = Collapsible.init False, toasts = Toast.init, layers = Layer.init }, update = update, view = view }


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
            { model | saved = True, toasts = Toast.add { id = "saved", title = "Profile saved", message = "Your changes are available now." } model.toasts }

        SelectTab value ->
            { model | tab = value }

        SetPage value ->
            { model | page = value }

        DetailsMsg childMsg ->
            { model | details = Collapsible.update childMsg model.details }

        ToastMsg childMsg ->
            { model | toasts = Toast.update childMsg model.toasts }

        OpenLayer kind id ->
            { model | layers = Layer.open kind id model.layers }

        DismissLayer id reason ->
            { model | layers = Layer.dismiss reason id model.layers }

        LayerAction id ->
            { model | layers = Layer.close id model.layers }


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
            , applicationStructure model
            , overlayExamples model
            , compositeExamples model
            ]
        , Toast.view ToastMsg [] model.toasts
        ]


compositeExamples : Model -> Html Msg
compositeExamples model =
    demo "Composite inputs"
        [ Typeahead.view
            { key = "people"
            , label = "Find a person"
            , query = model.name
            , options =
                [ { value = "Ada Lovelace", label = "Ada Lovelace", disabled = False }
                , { value = "Grace Hopper", label = "Grace Hopper", disabled = False }
                , { value = "Margaret Hamilton", label = "Margaret Hamilton", disabled = False }
                ]
            , open = True
            , active = Just 0
            , disabled = False
            , error = Nothing
            , onQuery = SetName
            , onSelect = SetName
            , attributes = []
            }
        , Calendar.view
            { label = "July 2026"
            , previousLabel = "Previous month"
            , nextLabel = "Next month"
            , days =
                List.repeat 3 Nothing
                    ++ List.map
                        (\day ->
                            Just
                                { value = day
                                , label = String.fromInt day
                                , accessibleLabel = "July " ++ String.fromInt day ++ ", 2026"
                                , selected = model.page == day
                                , today = day == 4
                                , disabled = False
                                }
                        )
                        (List.range 1 14)
            , onPrevious = SetPage (model.page - 1)
            , onNext = SetPage (model.page + 1)
            , onSelect = SetPage
            , attributes = []
            }
        , Carousel.view
            { label = "Product tour"
            , slides =
                [ { label = "Overview", content = [ text "Controlled selection and navigation." ] }
                , { label = "Details", content = [ text "Responsive and reduced-motion styles are inherited." ] }
                ]
            , current = model.page - 1
            , previousLabel = "Previous slide"
            , nextLabel = "Next slide"
            , onChange = \index -> SetPage (index + 1)
            , attributes = []
            }
        ]


overlayExamples : Model -> Html Msg
overlayExamples model =
    demo "Overlays"
        [ Stack.view [ Stack.horizontal, Stack.space "0.75rem", Stack.wrap ]
            []
            [ Button.view [ Button.secondary, Button.onClick (OpenLayer Layer.Modal "dialog-demo") ] [] [ text "Open dialog" ]
            , Button.view [ Button.destructive, Button.onClick (OpenLayer Layer.Modal "alert-demo") ] [] [ text "Open alert" ]
            , Tooltip.view
                { id = "tooltip-demo"
                , layers = model.layers
                , trigger = \attributes -> button ([ Events.onMouseEnter (OpenLayer Layer.NonModal "tooltip-demo"), Events.onMouseLeave (DismissLayer "tooltip-demo" Layer.OutsideClick) ] ++ attributes) [ text "Tooltip" ]
                , content = "Helpful detail"
                , attributes = []
                }
            , Popover.view
                { id = "popover-demo"
                , layers = model.layers
                , trigger = \attributes -> button (Events.onClick (OpenLayer Layer.NonModal "popover-demo") :: attributes) [ text "Popover" ]
                , content = [ text "Non-modal supporting content." ]
                , onDismiss = DismissLayer "popover-demo"
                , attributes = []
                }
            , DropdownMenu.view
                { id = "menu-demo"
                , layers = model.layers
                , trigger = \attributes -> button (Events.onClick (OpenLayer Layer.NonModal "menu-demo") :: attributes) [ text "Menu" ]
                , items = [ { label = "Edit", onSelect = LayerAction "menu-demo", disabled = False }, { label = "Unavailable", onSelect = LayerAction "menu-demo", disabled = True } ]
                , onDismiss = DismissLayer "menu-demo"
                , attributes = []
                }
            , Button.view [ Button.ghost, Button.onClick (OpenLayer Layer.NonModal "context-demo") ] [] [ text "Context menu fixture" ]
            ]
        , Dialog.view
            { id = "dialog-demo", layers = model.layers, title = "Edit profile", body = [ text "Dialog content remains application-owned." ], footer = [ button [ Events.onClick (LayerAction "dialog-demo") ] [ text "Done" ] ], onDismiss = DismissLayer "dialog-demo", attributes = [] }
        , AlertDialog.view
            { id = "alert-demo", layers = model.layers, title = "Delete item?", description = "This action cannot be undone.", cancelLabel = "Cancel", confirmLabel = "Delete", onCancel = LayerAction "alert-demo", onConfirm = LayerAction "alert-demo", attributes = [] }
        , ContextMenu.view
            { id = "context-demo", layers = model.layers, x = 32, y = 96, items = [ { label = "Inspect", onSelect = LayerAction "context-demo", disabled = False } ], onDismiss = DismissLayer "context-demo", attributes = [] }
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


applicationStructure : Model -> Html Msg
applicationStructure model =
    demo "CRUD application structure"
        [ Breadcrumbs.view [] [ { label = "Home", url = Just "#" }, { label = "People", url = Nothing } ]
        , Tabs.view
            { key = "directory"
            , selected = model.tab
            , onSelect = SelectTab
            , attributes = []
            , tabs =
                [ { id = "people", label = "People", disabled = False, panel = [ peopleTable ] }
                , { id = "empty", label = "Empty state", disabled = False, panel = [ EmptyState.view { title = "No archived people", description = "Archived records will appear here.", illustration = [ text "◇" ], actions = [ Button.view [ Button.primary ] [] [ text "Add person" ] ], attributes = [] } ] }
                , { id = "loading", label = "Loading", disabled = False, panel = [ Skeleton.text [], Skeleton.block [ Attr.style "margin-top" "0.75rem" ] ] }
                ]
            }
        , SegmentedControl.view { label = "Density", value = "comfortable", options = [ { value = "compact", label = "Compact", disabled = False }, { value = "comfortable", label = "Comfortable", disabled = False } ], onChange = \_ -> SelectTab model.tab, attributes = [] }
        , Item.list []
            [ Item.view { leading = [ text "AH" ], content = [ text "Ada Hamilton" ], trailing = [ Badge.view Status.Success [] [ text "Active" ] ], attributes = [] }
            , Item.view { leading = [ text "GT" ], content = [ text "Grace Turing" ], trailing = [ Badge.view Status.Info [] [ text "Invited" ] ], attributes = [] }
            ]
        , Pagination.view { page = model.page, pageCount = 3, onChange = SetPage, attributes = [] }
        , Collapsible.view { key = "audit", label = "Audit details", state = model.details, onChange = DetailsMsg, content = [ text "Created today by the showcase user." ], attributes = [] }
        , AppShell.view
            { top = [ TopNav.view { brand = [ text "Acme" ], links = [ text "Directory" ], actions = [ text "Account" ], attributes = [] } ]
            , navigation = [ SideNav.view { label = "Workspace", items = [ { label = "People", url = "#", current = True }, { label = "Settings", url = "#", current = False } ], attributes = [] } ]
            , content = [ text "Responsive shell preview" ]
            , attributes = [ Attr.style "min-height" "16rem", Attr.style "border" "1px solid var(--astryx-border)" ]
            }
        ]


peopleTable : Html msg
peopleTable =
    Table.view
        { caption = "People"
        , columns =
            [ { heading = "Name", view = \person -> text person.name }
            , { heading = "Role", view = \person -> text person.role }
            ]
        , rows = [ { id = "1", name = "Ada Hamilton", role = "Administrator" }, { id = "2", name = "Grace Turing", role = "Member" } ]
        , rowKey = .id
        , attributes = []
        }


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
