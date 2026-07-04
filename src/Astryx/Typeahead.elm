module Astryx.Typeahead exposing (Config, Option, matches, view)

{-| Accessible, controlled autocomplete.

@docs Config, Option, matches, view

-}

import Astryx.Accessibility as Accessibility
import Html exposing (Attribute, Html, button, div, input, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| A selectable suggestion.
-}
type alias Option a =
    { value : a, label : String, disabled : Bool }


{-| The application owns query, open state, and active option.
-}
type alias Config a msg =
    { key : String, label : String, query : String, options : List (Option a), open : Bool, active : Maybe Int, disabled : Bool, error : Maybe String, onQuery : String -> msg, onSelect : a -> msg, attributes : List (Attribute msg) }


{-| Case-insensitive label filtering. Disabled options remain visible.
-}
matches : String -> List (Option a) -> List (Option a)
matches query options =
    let
        needle =
            String.toLower (String.trim query)
    in
    if needle == "" then
        options

    else
        List.filter (\option -> String.contains needle (String.toLower option.label)) options


{-| Render a combobox and listbox. Keyboard highlight state remains application-owned.
-}
view : Config a msg -> Html msg
view config =
    let
        inputId =
            Accessibility.id "typeahead" config.key

        listId =
            Accessibility.id "typeahead-list" config.key

        visible =
            matches config.query config.options

        activeId =
            config.active |> Maybe.map (\index -> Accessibility.id "typeahead-option" (config.key ++ "-" ++ String.fromInt index))
    in
    div ([ Attr.class "astryx-composite-input" ] ++ config.attributes)
        ([ Html.label [ Attr.for inputId ] [ text config.label ]
         , input
            ([ Attr.id inputId
             , Attr.class "astryx-input"
             , Attr.value config.query
             , Attr.disabled config.disabled
             , Attr.attribute "role" "combobox"
             , Attr.attribute "aria-autocomplete" "list"
             , Attr.attribute "aria-controls" listId
             , Attr.attribute "aria-expanded" (bool config.open)
             , Events.onInput config.onQuery
             ]
                ++ (activeId |> Maybe.map (Attr.attribute "aria-activedescendant" >> List.singleton) |> Maybe.withDefault [])
            )
            []
         ]
            ++ (if config.open then
                    [ div [ Attr.id listId, Attr.class "astryx-listbox", Attr.attribute "role" "listbox" ]
                        (if List.isEmpty visible then
                            [ div [ Attr.class "astryx-empty-option" ] [ text "No results" ] ]

                         else
                            List.indexedMap (optionView config) visible
                        )
                    ]

                else
                    []
               )
            ++ (config.error |> Maybe.map (\message -> [ div [ Attr.class "astryx-field-status", Attr.attribute "aria-live" "polite" ] [ text message ] ]) |> Maybe.withDefault [])
        )


optionView : Config a msg -> Int -> Option a -> Html msg
optionView config index option =
    button
        [ Attr.id (Accessibility.id "typeahead-option" (config.key ++ "-" ++ String.fromInt index))
        , Attr.type_ "button"
        , Attr.attribute "role" "option"
        , Attr.attribute "aria-selected" (bool (config.active == Just index))
        , Attr.disabled option.disabled
        , Events.onClick (config.onSelect option.value)
        ]
        [ text option.label ]


bool : Bool -> String
bool value =
    if value then
        "true"

    else
        "false"
