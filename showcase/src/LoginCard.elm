module LoginCard exposing (Model, Msg, init, update, view)

import Astryx.Accessibility as Accessibility
import Astryx.Button as Button
import Astryx.Card as Card
import Astryx.Center as Center
import Astryx.Divider as Divider
import Astryx.Form.Field as Field
import Astryx.Form.TextInput as TextInput
import Astryx.Heading as Heading
import Astryx.Icon as Icon
import Astryx.Link as Link
import Astryx.Stack as Stack
import Astryx.Text as Text
import Html exposing (Html, form, node, span, text)
import Html.Attributes as Attr
import Html.Events as Events


type alias Model =
    { email : String
    , password : String
    , attempted : Bool
    , status : Status
    }


type Status
    = Idle
    | SigningIn
    | SignedIn String


type Msg
    = SetEmail String
    | SetPassword String
    | Submit
    | CompleteSignIn
    | SocialSignIn String
    | Reset


init : Model
init =
    { email = "", password = "", attempted = False, status = Idle }


update : Msg -> Model -> Model
update message model =
    case message of
        SetEmail value ->
            { model | email = value, attempted = False, status = Idle }

        SetPassword value ->
            { model | password = value, attempted = False, status = Idle }

        Submit ->
            if isValid model then
                { model | attempted = True, status = SigningIn }

            else
                { model | attempted = True, status = Idle }

        CompleteSignIn ->
            { model | status = SignedIn model.email }

        SocialSignIn provider ->
            { model | status = SignedIn (provider ++ " account") }

        Reset ->
            init


view : Model -> Html Msg
view model =
    Center.view
        [ Attr.style "min-height" "calc(100vh - 3.25rem)"
        , Attr.style "padding" "var(--astryx-space-md)"
        ]
        [ node "style" [] [ text ".login-card .astryx-field__label{position:absolute!important;width:1px!important;height:1px!important;padding:0!important;margin:-1px!important;overflow:hidden!important;clip:rect(0,0,0,0)!important;white-space:nowrap!important;border:0!important}" ]
        , Stack.view [ Stack.vertical, Stack.space "var(--astryx-space-md)", Stack.align "center" ]
            [ Attr.class "login-card", Attr.style "width" "min(100%, 25rem)" ]
            [ Stack.view [ Stack.vertical, Stack.space "var(--astryx-space-xs)", Stack.align "center" ]
                []
                [ Icon.view (Icon.decorative (span [] [ text "◉" ]))
                , Text.view Text.normal [] [ text "Product Inc." ]
                ]
            , Card.view
                { header = []
                , body =
                    [ Stack.view [ Stack.vertical, Stack.space "var(--astryx-space-md)" ]
                        []
                        ([ Stack.view [ Stack.vertical, Stack.space "var(--astryx-space-xs)", Stack.align "center" ]
                            [ Attr.style "text-align" "center" ]
                            [ Heading.view Heading.h1 [ Attr.style "font-size" "1.5rem" ] [ text "Welcome back" ]
                            , Text.view Text.muted [] [ text "Sign in to continue." ]
                            ]
                         , loginForm model
                         , Stack.view [ Stack.horizontal, Stack.space "var(--astryx-space-sm)" ]
                            [ Attr.style "align-items" "center" ]
                            [ Divider.decorative [ Attr.style "flex" "1" ]
                            , Text.view Text.muted [] [ text "or continue with" ]
                            , Divider.decorative [ Attr.style "flex" "1" ]
                            ]
                         , socialButton "Apple" "A"
                         , socialButton "Google" "G"
                         , Text.view Text.muted
                            [ Attr.style "text-align" "center" ]
                            [ text "Don’t have an account? "
                            , Link.view "#create-account" [] [] [ text "Sign up" ]
                            ]
                         ]
                            ++ statusContent model.status
                        )
                    ]
                , footer = []
                , attributes = [ Attr.style "width" "100%" ]
                }
            , Text.view Text.muted
                [ Attr.style "font-size" "0.75rem", Attr.style "text-align" "center" ]
                [ text "By clicking continue, you agree to our "
                , Link.view "#terms" [] [] [ text "Terms of Service" ]
                , text " and "
                , Link.view "#privacy" [] [] [ text "Privacy Policy" ]
                , text "."
                ]
            ]
        ]


loginForm : Model -> Html Msg
loginForm model =
    form [ Events.onSubmit Submit, Attr.novalidate True ]
        [ Stack.view [ Stack.vertical, Stack.space "var(--astryx-space-md)" ]
            []
            [ Field.view
                { key = "login-card-email"
                , label = "Email address"
                , description = Nothing
                , error = visibleError model emailError
                , required = True
                , control =
                    \wiring ->
                        TextInput.view
                            { wiring = wiring
                            , value = model.email
                            , onInput = SetEmail
                            , inputType = TextInput.Email
                            , disabled = model.status == SigningIn
                            , readOnly = False
                            , attributes = [ Attr.attribute "autocomplete" "email", Attr.placeholder "name@company.com" ]
                            }
                }
            , Field.view
                { key = "login-card-password"
                , label = "Password"
                , description = Just "Use at least 8 characters."
                , error = visibleError model passwordError
                , required = True
                , control =
                    \wiring ->
                        TextInput.view
                            { wiring = wiring
                            , value = model.password
                            , onInput = SetPassword
                            , inputType = TextInput.Password
                            , disabled = model.status == SigningIn
                            , readOnly = False
                            , attributes = [ Attr.attribute "autocomplete" "current-password", Attr.placeholder "Enter your password" ]
                            }
                }
            , Button.view
                [ Button.primary
                , Button.submit
                , Button.disabled (model.status == SigningIn)
                , Button.loading (model.status == SigningIn)
                ]
                [ Attr.style "width" "100%" ]
                [ text
                    (if model.status == SigningIn then
                        "Signing in"

                     else
                        "Login"
                    )
                ]
            ]
        ]


socialButton : String -> String -> Html Msg
socialButton provider mark =
    Button.view
        [ Button.secondary, Button.button, Button.onClick (SocialSignIn provider) ]
        [ Attr.style "width" "100%" ]
        [ Icon.view (Icon.decorative (span [ Attr.attribute "aria-hidden" "true" ] [ text mark ]))
        , span [ Attr.style "margin-left" "var(--astryx-space-sm)" ] [ text ("Continue with " ++ provider) ]
        ]


statusContent : Status -> List (Html Msg)
statusContent status =
    case status of
        Idle ->
            []

        SigningIn ->
            [ Accessibility.liveRegion [] [ text "Sign-in request is in progress." ]
            , Button.view [ Button.secondary, Button.onClick CompleteSignIn ] [] [ text "Complete demo request" ]
            , Button.view [ Button.ghost, Button.onClick Reset ] [] [ text "Cancel and reset" ]
            ]

        SignedIn account ->
            [ Accessibility.liveRegion [] [ text ("Signed in with " ++ account ++ ".") ]
            , Button.view [ Button.secondary, Button.onClick Reset ] [] [ text "Reset login demo" ]
            ]


visibleError : Model -> (Model -> Maybe String) -> Maybe String
visibleError model validate =
    if model.attempted then
        validate model

    else
        Nothing


emailError : Model -> Maybe String
emailError model =
    if String.contains "@" model.email && not (String.endsWith "@" model.email) then
        Nothing

    else
        Just "Enter a valid email address."


passwordError : Model -> Maybe String
passwordError model =
    if String.length model.password >= 8 then
        Nothing

    else
        Just "Password must contain at least 8 characters."


isValid : Model -> Bool
isValid model =
    emailError model == Nothing && passwordError model == Nothing
