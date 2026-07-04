module Astryx.Form.Field exposing (Config, Wiring, view)

{-| Shared labels, descriptions, validation, and ARIA wiring.

@docs Config, Wiring, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Form.FieldStatus as FieldStatus
import Astryx.Status as Status
import Html exposing (Html, div, label, span, text)
import Html.Attributes as Attr


{-| Identifiers and validation state passed to a control.
-}
type alias Wiring =
    { id : String, labelledBy : String, describedBy : List String, invalid : Bool }


{-| Field label, supporting content, and control renderer.
-}
type alias Config msg =
    { key : String
    , label : String
    , description : Maybe String
    , error : Maybe String
    , required : Bool
    , control : Wiring -> Html msg
    }


{-| Render a field with deterministic ARIA relationships.
-}
view : Config msg -> Html msg
view config =
    let
        controlId =
            Accessibility.id "control" config.key

        labelId =
            Accessibility.id "label" config.key

        descriptionId =
            Accessibility.id "description" config.key

        errorId =
            Accessibility.id "error" config.key

        described =
            (if config.description == Nothing then
                []

             else
                [ descriptionId ]
            )
                ++ (if config.error == Nothing then
                        []

                    else
                        [ errorId ]
                   )

        wiring =
            { id = controlId, labelledBy = labelId, describedBy = described, invalid = config.error /= Nothing }
    in
    div [ Attr.class "astryx-field" ]
        ([ label [ Attr.id labelId, Attr.for controlId, Attr.class "astryx-field__label" ]
            ([ text config.label ]
                ++ (if config.required then
                        [ span [ Attr.attribute "aria-hidden" "true" ] [ text " *" ] ]

                    else
                        []
                   )
            )
         , config.control wiring
         ]
            ++ (case config.description of
                    Just description ->
                        [ div [ Attr.id descriptionId, Attr.class "astryx-field__description" ] [ text description ] ]

                    Nothing ->
                        []
               )
            ++ (case config.error of
                    Just error ->
                        [ FieldStatus.view Status.Danger [ Attr.id errorId ] [ text error ] ]

                    Nothing ->
                        []
               )
        )
