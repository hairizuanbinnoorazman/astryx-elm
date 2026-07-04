module Astryx.Toast exposing (State, Toast, Msg(..), init, add, dismiss, update, view)

{-| An explicit state machine for application notifications.

Timing is application-owned: send `Dismiss id` from a timer when expiry is
required. This keeps subscriptions and time dependencies out of the package.

@docs State, Toast, Msg, init, add, dismiss, update, view

-}

import Html exposing (Attribute, Html, button, div, p, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| One notification. IDs must be stable and unique.
-}
type alias Toast =
    { id : String, title : String, message : String }


{-| Opaque collection state.
-}
type State
    = State (List Toast)


{-| Notification transitions.
-}
type Msg
    = Add Toast
    | Dismiss String
    | Clear


{-| Empty notification state.
-}
init : State
init =
    State []


{-| Add or replace a notification with the same ID.
-}
add : Toast -> State -> State
add toast (State toasts) =
    State (toast :: List.filter (\item -> item.id /= toast.id) toasts)


{-| Remove a notification.
-}
dismiss : String -> State -> State
dismiss id (State toasts) =
    State (List.filter (\item -> item.id /= id) toasts)


{-| Apply a notification transition.
-}
update : Msg -> State -> State
update msg state =
    case msg of
        Add toast ->
            add toast state

        Dismiss id ->
            dismiss id state

        Clear ->
            init


{-| Render the notification region. Map messages in the parent update.
-}
view : (Msg -> msg) -> List (Attribute msg) -> State -> Html msg
view toMsg attributes (State toasts) =
    div ([ Attr.class "astryx-toast-region", Attr.attribute "aria-label" "Notifications" ] ++ attributes) (List.map (toastView toMsg) (List.reverse toasts))


toastView : (Msg -> msg) -> Toast -> Html msg
toastView toMsg toast =
    div [ Attr.class "astryx-toast", Attr.attribute "role" "status" ]
        [ div [] [ Html.strong [] [ text toast.title ], p [] [ text toast.message ] ]
        , button [ Attr.type_ "button", Attr.attribute "aria-label" ("Dismiss " ++ toast.title), Events.onClick (toMsg (Dismiss toast.id)) ] [ text "×" ]
        ]
