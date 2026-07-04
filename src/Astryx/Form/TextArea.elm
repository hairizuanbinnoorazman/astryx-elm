module Astryx.Form.TextArea exposing (Config, Resize(..), view)

{-| Controlled native text areas.

@docs Config, Resize, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Form.Field exposing (Wiring)
import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, textarea)
import Html.Attributes as Attr
import Html.Events as Events


{-| Text-area resize policy.
-}
type Resize
    = None
    | Vertical
    | Both


{-| Controlled text-area configuration.
-}
type alias Config msg =
    { wiring : Wiring, value : String, onInput : String -> msg, rows : Int, resize : Resize, disabled : Bool, readOnly : Bool, attributes : List (Attribute msg) }


{-| Render a native text area connected to a field.
-}
view : Config msg -> Html msg
view config =
    textarea
        (Attributes.merge
            [ Attr.class "astryx-input"
            , Attr.id config.wiring.id
            , Attr.value config.value
            , Attr.rows config.rows
            , Attr.style "resize" (resizeName config.resize)
            , Events.onInput config.onInput
            , Attr.disabled config.disabled
            , Attr.readonly config.readOnly
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
        []


resizeName : Resize -> String
resizeName resize =
    case resize of
        None ->
            "none"

        Vertical ->
            "vertical"

        Both ->
            "both"
