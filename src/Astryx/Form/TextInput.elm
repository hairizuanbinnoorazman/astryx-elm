module Astryx.Form.TextInput exposing (Config, InputType(..), view)

{-| Controlled native text inputs.

@docs Config, InputType, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Form.Field exposing (Wiring)
import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, input)
import Html.Attributes as Attr
import Html.Events as Events


{-| Supported native input types.
-}
type InputType
    = Text
    | Email
    | Password
    | Search
    | Tel
    | Url


{-| Controlled text-input configuration.
-}
type alias Config msg =
    { wiring : Wiring, value : String, onInput : String -> msg, inputType : InputType, disabled : Bool, readOnly : Bool, attributes : List (Attribute msg) }


{-| Render a native input connected to a field.
-}
view : Config msg -> Html msg
view config =
    input
        (Attributes.merge
            [ Attr.class "astryx-input"
            , Attr.id config.wiring.id
            , Attr.type_ (typeName config.inputType)
            , Attr.value config.value
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


typeName : InputType -> String
typeName inputType =
    case inputType of
        Text ->
            "text"

        Email ->
            "email"

        Password ->
            "password"

        Search ->
            "search"

        Tel ->
            "tel"

        Url ->
            "url"
