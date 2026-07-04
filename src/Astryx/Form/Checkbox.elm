module Astryx.Form.Checkbox exposing (Config, view)

{-| Controlled native checkboxes.

@docs Config, view

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, input, label, span, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| Controlled checkbox configuration.
-}
type alias Config msg =
    { id : String, label : String, checked : Bool, indeterminate : Bool, disabled : Bool, onChange : Bool -> msg, attributes : List (Attribute msg) }


{-| Render a native checkbox and associated label.
-}
view : Config msg -> Html msg
view config =
    label [ Attr.class "astryx-checkbox" ]
        [ input
            (Attributes.merge
                [ Attr.id config.id
                , Attr.type_ "checkbox"
                , Attr.checked config.checked
                , Attr.disabled config.disabled
                , Attr.attribute "aria-checked"
                    (if config.indeterminate then
                        "mixed"

                     else if config.checked then
                        "true"

                     else
                        "false"
                    )
                , Events.onCheck config.onChange
                ]
                config.attributes
            )
            []
        , span [] [ text config.label ]
        ]
