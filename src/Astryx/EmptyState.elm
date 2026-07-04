module Astryx.EmptyState exposing (Config, view)

{-| Empty collection and first-use states.

@docs Config, view

-}

import Html exposing (Attribute, Html, div, h2, p, text)
import Html.Attributes as Attr


{-| Empty-state content slots.
-}
type alias Config msg =
    { title : String, description : String, illustration : List (Html msg), actions : List (Html msg), attributes : List (Attribute msg) }


{-| Render a presentational empty state.
-}
view : Config msg -> Html msg
view config =
    div ([ Attr.class "astryx-empty-state" ] ++ config.attributes)
        [ div [ Attr.attribute "aria-hidden" "true" ] config.illustration, h2 [] [ text config.title ], p [] [ text config.description ], div [ Attr.class "astryx-empty-state__actions" ] config.actions ]
