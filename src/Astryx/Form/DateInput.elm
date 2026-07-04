module Astryx.Form.DateInput exposing (Config, view)

{-| Native date input with Field wiring.

@docs Config, view

-}

import Astryx.Form.Field exposing (Wiring)
import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, input)
import Html.Attributes as Attr
import Html.Events as Events


{-| Controlled ISO date input.
-}
type alias Config msg =
    { wiring : Wiring, value : String, minimum : Maybe String, maximum : Maybe String, disabled : Bool, readOnly : Bool, onInput : String -> msg, attributes : List (Attribute msg) }


{-| Render a browser-native date control.
-}
view : Config msg -> Html msg
view config =
    input
        (Attributes.merge
            ([ Attr.class "astryx-input"
             , Attr.id config.wiring.id
             , Attr.type_ "date"
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
                ++ bounds config
            )
            config.attributes
        )
        []


bounds : Config msg -> List (Attribute msg)
bounds config =
    List.filterMap identity [ Maybe.map Attr.min config.minimum, Maybe.map Attr.max config.maximum ]
