module Astryx.Calendar exposing (Day, Config, view)

{-| Application-supplied calendar grid, avoiding timezone assumptions.

@docs Day, Config, view

-}

import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| One day cell. Empty cells align the first week.
-}
type alias Day a =
    { value : a, label : String, accessibleLabel : String, selected : Bool, today : Bool, disabled : Bool }


{-| Controlled month configuration. `days` should include leading empty cells.
-}
type alias Config a msg =
    { label : String, previousLabel : String, nextLabel : String, days : List (Maybe (Day a)), onPrevious : msg, onNext : msg, onSelect : a -> msg, attributes : List (Attribute msg) }


{-| Render a seven-column calendar grid.
-}
view : Config a msg -> Html msg
view config =
    div ([ Attr.class "astryx-calendar", Attr.attribute "aria-label" config.label ] ++ config.attributes)
        [ div [ Attr.class "astryx-calendar__header" ]
            [ button [ Attr.type_ "button", Attr.attribute "aria-label" config.previousLabel, Events.onClick config.onPrevious ] [ text "‹" ]
            , div [ Attr.attribute "aria-live" "polite" ] [ text config.label ]
            , button [ Attr.type_ "button", Attr.attribute "aria-label" config.nextLabel, Events.onClick config.onNext ] [ text "›" ]
            ]
        , div [ Attr.class "astryx-calendar__grid", Attr.attribute "role" "grid" ] (List.map (cell config) config.days)
        ]


cell : Config a msg -> Maybe (Day a) -> Html msg
cell config maybeDay =
    case maybeDay of
        Nothing ->
            div [ Attr.attribute "role" "gridcell" ] []

        Just day ->
            button
                [ Attr.type_ "button"
                , Attr.attribute "role" "gridcell"
                , Attr.attribute "aria-label" day.accessibleLabel
                , Attr.attribute "aria-selected" (bool day.selected)
                , Attr.attribute "aria-current"
                    (if day.today then
                        "date"

                     else
                        "false"
                    )
                , Attr.disabled day.disabled
                , Events.onClick (config.onSelect day.value)
                ]
                [ text day.label ]


bool : Bool -> String
bool value =
    if value then
        "true"

    else
        "false"
