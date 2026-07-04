module Astryx.Form.RadioGroup exposing (Config, Option, view)

{-| Controlled groups of native radio buttons.

@docs Config, Option, view

-}

import Astryx.Accessibility as Accessibility
import Html exposing (Attribute, Html, div, input, label, legend, span, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| One radio choice.
-}
type alias Option =
    { value : String, label : String, description : Maybe String, disabled : Bool }


{-| Controlled radio-group configuration.
-}
type alias Config msg =
    { key : String, label : String, value : Maybe String, options : List Option, onChange : String -> msg, error : Maybe String, attributes : List (Attribute msg) }


{-| Render a native fieldset of radio controls.
-}
view : Config msg -> Html msg
view config =
    Html.fieldset ([ Attr.class "astryx-radio-group" ] ++ config.attributes)
        ([ legend [] [ text config.label ] ]
            ++ List.map (optionView config) config.options
            ++ (case config.error of
                    Just message ->
                        [ div [ Attr.class "astryx-field-status", Attr.attribute "aria-live" "polite" ] [ text message ] ]

                    Nothing ->
                        []
               )
        )


optionView : Config msg -> Option -> Html msg
optionView config option =
    let
        optionId =
            Accessibility.id "radio" (config.key ++ "-" ++ option.value)
    in
    label [ Attr.for optionId, Attr.class "astryx-radio" ]
        [ input [ Attr.id optionId, Attr.type_ "radio", Attr.name config.key, Attr.value option.value, Attr.checked (config.value == Just option.value), Attr.disabled option.disabled, Events.onCheck (\_ -> config.onChange option.value) ] []
        , span []
            ([ text option.label ]
                ++ (case option.description of
                        Just description ->
                            [ span [ Attr.class "astryx-field__description" ] [ text description ] ]

                        Nothing ->
                            []
                   )
            )
        ]
