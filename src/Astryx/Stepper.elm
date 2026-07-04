module Astryx.Stepper exposing (State(..), Step, view)

{-| Progress through a fixed sequence of steps.

The application owns step state. `Current` is announced with `aria-current`,
while every state has visible and screen-reader text so color is never the only
signal.

@docs State, Step, view

-}

import Html exposing (Attribute, Html, li, ol, span, text)
import Html.Attributes as Attr


{-| The state of one step.
-}
type State
    = Pending
    | Current
    | Complete
    | Error


{-| A labelled step. Descriptions are optional supporting content.
-}
type alias Step =
    { label : String
    , description : Maybe String
    , state : State
    }


{-| Render an ordered step list with an accessible label.
-}
view : String -> List (Attribute msg) -> List Step -> Html msg
view label attributes steps =
    ol
        ([ Attr.class "astryx-stepper", Attr.attribute "aria-label" label ] ++ attributes)
        (List.indexedMap stepView steps)


stepView : Int -> Step -> Html msg
stepView index step =
    li
        ([ Attr.class "astryx-stepper__step"
         , Attr.class ("astryx-stepper__step--" ++ stateName step.state)
         ]
            ++ (if step.state == Current then
                    [ Attr.attribute "aria-current" "step" ]

                else
                    []
               )
        )
        [ span [ Attr.class "astryx-stepper__marker", Attr.attribute "aria-hidden" "true" ]
            [ text
                (if step.state == Complete then
                    "✓"

                 else if step.state == Error then
                    "!"

                 else
                    String.fromInt (index + 1)
                )
            ]
        , span [ Attr.class "astryx-stepper__content" ]
            ([ span [ Attr.class "astryx-stepper__label" ] [ text step.label ]
             , span [ Attr.class "astryx-visually-hidden" ] [ text (", " ++ stateLabel step.state) ]
             ]
                ++ (case step.description of
                        Just description ->
                            [ span [ Attr.class "astryx-stepper__description" ] [ text description ] ]

                        Nothing ->
                            []
                   )
            )
        ]


stateName : State -> String
stateName state =
    case state of
        Pending ->
            "pending"

        Current ->
            "current"

        Complete ->
            "complete"

        Error ->
            "error"


stateLabel : State -> String
stateLabel state =
    case state of
        Pending ->
            "not started"

        Current ->
            "current step"

        Complete ->
            "complete"

        Error ->
            "has an error"
