module Astryx.Form.Select exposing (Config, Option, view)

{-| Controlled native selects.

@docs Config, Option, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Form.Field exposing (Wiring)
import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, option, select, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| One native select option.
-}
type alias Option =
    { value : String, label : String, disabled : Bool }


{-| Controlled select configuration.
-}
type alias Config msg =
    { wiring : Wiring, value : String, placeholder : Maybe String, options : List Option, disabled : Bool, onChange : String -> msg, attributes : List (Attribute msg) }


{-| Render a native select connected to a field.
-}
view : Config msg -> Html msg
view config =
    select
        (Attributes.merge
            [ Attr.class "astryx-input"
            , Attr.id config.wiring.id
            , Attr.value config.value
            , Attr.disabled config.disabled
            , Events.onInput config.onChange
            , Accessibility.labelledBy [ config.wiring.labelledBy ]
            , Accessibility.describedBy config.wiring.describedBy
            , Attr.attribute "aria-invalid"
                (if config.wiring.invalid then
                    "true"

                 else
                    "false"
                )
            ]
            config.attributes
        )
        ((case config.placeholder of
            Just label ->
                [ option [ Attr.value "", Attr.disabled True ] [ text label ] ]

            Nothing ->
                []
         )
            ++ List.map optionView config.options
        )


optionView : Option -> Html msg
optionView item =
    option [ Attr.value item.value, Attr.disabled item.disabled ] [ text item.label ]
