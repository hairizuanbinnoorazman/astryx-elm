module Astryx.Collapsible exposing (State, Msg(..), Config, init, isOpen, update, view)

{-| An explicit disclosure state machine.

@docs State, Msg, Config, init, isOpen, update, view

-}

import Astryx.Accessibility as Accessibility
import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| Opaque disclosure state.
-}
type State
    = State Bool


{-| Disclosure transitions.
-}
type Msg
    = Toggle
    | Open
    | Close


{-| Disclosure content.
-}
type alias Config msg =
    { key : String, label : String, state : State, onChange : Msg -> msg, content : List (Html msg), attributes : List (Attribute msg) }


{-| Create disclosure state.
-}
init : Bool -> State
init =
    State


{-| Inspect whether content is expanded.
-}
isOpen : State -> Bool
isOpen (State open) =
    open


{-| Apply a transition.
-}
update : Msg -> State -> State
update msg (State open) =
    case msg of
        Toggle ->
            State (not open)

        Open ->
            State True

        Close ->
            State False


{-| Render a disclosure button and region.
-}
view : Config msg -> Html msg
view config =
    let
        open =
            isOpen config.state

        regionId =
            Accessibility.id "collapsible" config.key
    in
    div ([ Attr.class "astryx-collapsible" ] ++ config.attributes)
        ([ button
            [ Attr.type_ "button"
            , Attr.attribute "aria-expanded"
                (if open then
                    "true"

                 else
                    "false"
                )
            , Attr.attribute "aria-controls" regionId
            , Events.onClick (config.onChange Toggle)
            ]
            [ text config.label ]
         ]
            ++ (if open then
                    [ div [ Attr.id regionId ] config.content ]

                else
                    []
               )
        )
