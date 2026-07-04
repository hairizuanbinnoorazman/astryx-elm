module Astryx.Form.DateTimeInput exposing (Config, view)

{-| Native local date-time input with Field wiring.

@docs Config, view

-}

import Astryx.Form.Field exposing (Wiring)
import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, input)
import Html.Attributes as Attr
import Html.Events as Events


{-| Controlled local date-time input.
-}
type alias Config msg =
    { wiring : Wiring, value : String, disabled : Bool, readOnly : Bool, onInput : String -> msg, attributes : List (Attribute msg) }


{-| Render a browser-native datetime-local control.
-}
view : Config msg -> Html msg
view config =
    input
        (Attributes.merge
            [ Attr.class "astryx-input"
            , Attr.id config.wiring.id
            , Attr.type_ "datetime-local"
            , Attr.value config.value
            , Attr.disabled config.disabled
            , Attr.readonly config.readOnly
            , Attr.attribute "aria-labelledby" config.wiring.labelledBy
            , Attr.attribute "aria-describedby" (String.join " " config.wiring.describedBy)
            , Attr.attribute "aria-invalid"
                (if config.wiring.invalid then
                    "true"

                 else
                    "false"
                )
            , Events.onInput config.onInput
            ]
            config.attributes
        )
        []
