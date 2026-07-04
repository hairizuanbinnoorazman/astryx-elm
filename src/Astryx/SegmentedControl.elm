module Astryx.SegmentedControl exposing (Option, Config, view)

{-| A controlled single-choice segmented control.

@docs Option, Config, view

-}

import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| One choice.
-}
type alias Option =
    { value : String, label : String, disabled : Bool }


{-| Controlled choice configuration.
-}
type alias Config msg =
    { label : String, value : String, options : List Option, onChange : String -> msg, attributes : List (Attribute msg) }


{-| Render a labelled group of toggle buttons.
-}
view : Config msg -> Html msg
view config =
    div ([ Attr.class "astryx-segmented", Attr.attribute "role" "group", Attr.attribute "aria-label" config.label ] ++ config.attributes)
        (List.map (optionView config) config.options)


optionView : Config msg -> Option -> Html msg
optionView config option =
    button
        [ Attr.type_ "button"
        , Attr.class "astryx-segmented__option"
        , Attr.attribute "aria-pressed"
            (if option.value == config.value then
                "true"

             else
                "false"
            )
        , Attr.disabled option.disabled
        , Events.onClick (config.onChange option.value)
        ]
        [ text option.label ]
