module Astryx.Form.DateRangeInput exposing (Config, view)

{-| Paired native date range input.

@docs Config, view

-}

import Astryx.Accessibility as Accessibility
import Html exposing (Attribute, Html, div, input, label, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| Controlled date range.
-}
type alias Config msg =
    { key : String, label : String, startLabel : String, endLabel : String, start : String, end : String, disabled : Bool, error : Maybe String, onStart : String -> msg, onEnd : String -> msg, attributes : List (Attribute msg) }


{-| Render start/end controls with range constraints.
-}
view : Config msg -> Html msg
view config =
    let
        startId =
            Accessibility.id "range-start" config.key

        endId =
            Accessibility.id "range-end" config.key
    in
    Html.fieldset ([ Attr.class "astryx-date-range" ] ++ config.attributes)
        ([ Html.legend [] [ text config.label ]
         , label [ Attr.for startId ] [ text config.startLabel ]
         , input [ Attr.id startId, Attr.class "astryx-input", Attr.type_ "date", Attr.value config.start, Attr.max config.end, Attr.disabled config.disabled, Events.onInput config.onStart ] []
         , label [ Attr.for endId ] [ text config.endLabel ]
         , input [ Attr.id endId, Attr.class "astryx-input", Attr.type_ "date", Attr.value config.end, Attr.min config.start, Attr.disabled config.disabled, Events.onInput config.onEnd ] []
         ]
            ++ (config.error |> Maybe.map (\message -> [ div [ Attr.class "astryx-field-status", Attr.attribute "aria-live" "polite" ] [ text message ] ]) |> Maybe.withDefault [])
        )
