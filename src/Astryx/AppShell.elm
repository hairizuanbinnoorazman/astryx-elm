module Astryx.AppShell exposing (Config, view)

{-| Responsive application frame.

@docs Config, view

-}

import Html exposing (Attribute, Html, div, header, main_)
import Html.Attributes as Attr


{-| Shell regions. Navigation can contain `SideNav.view`.
-}
type alias Config msg =
    { top : List (Html msg), navigation : List (Html msg), content : List (Html msg), attributes : List (Attribute msg) }


{-| Render header, navigation, and main content landmarks.
-}
view : Config msg -> Html msg
view config =
    div ([ Attr.class "astryx-app-shell" ] ++ config.attributes)
        [ header [ Attr.class "astryx-app-shell__top" ] config.top
        , div [ Attr.class "astryx-app-shell__nav" ] config.navigation
        , main_ [ Attr.class "astryx-app-shell__main", Attr.tabindex -1 ] config.content
        ]
