module Astryx.TopNav exposing (Config, view)

{-| Top-level application navigation.

@docs Config, view

-}

import Html exposing (Attribute, Html, div, nav)
import Html.Attributes as Attr


{-| Brand, navigation, and action regions.
-}
type alias Config msg =
    { brand : List (Html msg), links : List (Html msg), actions : List (Html msg), attributes : List (Attribute msg) }


{-| Render a responsive top navigation landmark.
-}
view : Config msg -> Html msg
view config =
    nav ([ Attr.class "astryx-top-nav", Attr.attribute "aria-label" "Primary" ] ++ config.attributes)
        [ div [ Attr.class "astryx-top-nav__brand" ] config.brand, div [ Attr.class "astryx-top-nav__links" ] config.links, div [ Attr.class "astryx-top-nav__actions" ] config.actions ]
