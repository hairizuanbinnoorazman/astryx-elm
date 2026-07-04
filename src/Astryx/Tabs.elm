module Astryx.Tabs exposing (Tab, Config, view)

{-| Controlled tabs with automatic keyboard navigation supplied by native buttons.

@docs Tab, Config, view

-}

import Astryx.Accessibility as Accessibility
import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| One tab and its panel.
-}
type alias Tab msg =
    { id : String, label : String, panel : List (Html msg), disabled : Bool }


{-| Controlled tab configuration.
-}
type alias Config msg =
    { key : String, selected : String, tabs : List (Tab msg), onSelect : String -> msg, attributes : List (Attribute msg) }


{-| Render a tab list and the selected panel. The application owns selection.
-}
view : Config msg -> Html msg
view config =
    div ([ Attr.class "astryx-tabs" ] ++ config.attributes)
        ([ div [ Attr.class "astryx-tabs__list", Attr.attribute "role" "tablist" ] (List.map (tabButton config) config.tabs) ]
            ++ List.filterMap (panel config) config.tabs
        )


tabButton : Config msg -> Tab msg -> Html msg
tabButton config tab =
    let
        selected =
            tab.id == config.selected
    in
    button
        [ Attr.id (Accessibility.id "tab" (config.key ++ "-" ++ tab.id))
        , Attr.attribute "role" "tab"
        , Attr.attribute "aria-selected" (boolString selected)
        , Attr.attribute "aria-controls" (Accessibility.id "tabpanel" (config.key ++ "-" ++ tab.id))
        , Attr.tabindex
            (if selected then
                0

             else
                -1
            )
        , Attr.disabled tab.disabled
        , Events.onClick (config.onSelect tab.id)
        ]
        [ text tab.label ]


panel : Config msg -> Tab msg -> Maybe (Html msg)
panel config tab =
    if tab.id == config.selected then
        Just (div [ Attr.id (Accessibility.id "tabpanel" (config.key ++ "-" ++ tab.id)), Attr.attribute "role" "tabpanel", Attr.attribute "aria-labelledby" (Accessibility.id "tab" (config.key ++ "-" ++ tab.id)), Attr.tabindex 0 ] tab.panel)

    else
        Nothing


boolString : Bool -> String
boolString value =
    if value then
        "true"

    else
        "false"
