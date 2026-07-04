module Astryx.Banner exposing (Config, view)

{-| Page-level semantic feedback.

@docs Config, view

-}

import Astryx.Button as Button
import Astryx.Status as Status exposing (Status)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes as Attr


{-| Banner content and optional dismissal message.
-}
type alias Config msg =
    { status : Status, title : String, body : List (Html msg), dismiss : Maybe msg, attributes : List (Attribute msg) }


{-| Render page-level semantic feedback.
-}
view : Config msg -> Html msg
view config =
    div
        ([ Attr.class "astryx-banner"
         , Attr.class ("astryx-status--" ++ Status.toString config.status)
         , Attr.attribute "role"
            (if config.status == Status.Danger then
                "alert"

             else
                "status"
            )
         ]
            ++ config.attributes
        )
        ([ Html.strong [] [ text config.title ], div [] config.body ]
            ++ (case config.dismiss of
                    Just message ->
                        [ Button.view [ Button.ghost, Button.onClick message ] [ Attr.attribute "aria-label" ("Dismiss " ++ config.title) ] [ text "×" ] ]

                    Nothing ->
                        []
               )
        )
