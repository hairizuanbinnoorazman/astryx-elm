module Astryx.MultiSelector exposing (Config, Option, remaining, view)

{-| Searchable multiple-value selector.

@docs Config, Option, remaining, view

-}

import Astryx.Typeahead as Typeahead
import Html exposing (Attribute, Html, button, div, span, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| An option with a stable string key.
-}
type alias Option a =
    { key : String, value : a, label : String, disabled : Bool }


{-| Controlled multiple selector.
-}
type alias Config a msg =
    { key : String, label : String, query : String, options : List (Option a), selected : List (Option a), open : Bool, active : Maybe Int, disabled : Bool, error : Maybe String, onQuery : String -> msg, onSelect : a -> msg, onRemove : a -> msg, attributes : List (Attribute msg) }


{-| Exclude selected values by stable key.
-}
remaining : List (Option a) -> List (Option a) -> List (Option a)
remaining selected options =
    List.filter (\option -> not (List.any (\item -> item.key == option.key) selected)) options


{-| Render selected chips and an autocomplete for remaining values.
-}
view : Config a msg -> Html msg
view config =
    div ([ Attr.class "astryx-multi-selector" ] ++ config.attributes)
        [ div [ Attr.class "astryx-chips" ] (List.map (chip config) config.selected)
        , Typeahead.view
            { key = config.key
            , label = config.label
            , query = config.query
            , options = remaining config.selected config.options |> List.map (\o -> { value = o.value, label = o.label, disabled = o.disabled })
            , open = config.open
            , active = config.active
            , disabled = config.disabled
            , error = config.error
            , onQuery = config.onQuery
            , onSelect = config.onSelect
            , attributes = []
            }
        ]


chip : Config a msg -> Option a -> Html msg
chip config option =
    span [ Attr.class "astryx-chip" ] [ text option.label, button [ Attr.type_ "button", Attr.disabled config.disabled, Attr.attribute "aria-label" ("Remove " ++ option.label), Events.onClick (config.onRemove option.value) ] [ text "×" ] ]
