module Main exposing (main)

import Astryx.Accessibility as Accessibility
import Astryx.Center as Center
import Astryx.Grid as Grid
import Astryx.Heading as Heading
import Astryx.Icon as Icon
import Astryx.Size as Size
import Astryx.Stack as Stack
import Astryx.Status as Status
import Astryx.Text as Text
import Astryx.Theme as Theme
import Browser
import Html exposing (Html, button, code, nav, section, span, text)
import Html.Attributes as Attr
import Html.Events as Events


type alias Model =
    { dark : Bool }


type Msg
    = ToggleTheme


main : Program () Model Msg
main =
    Browser.sandbox { init = { dark = False }, update = update, view = view }


update : Msg -> Model -> Model
update ToggleTheme model =
    { model | dark = not model.dark }


view : Model -> Html Msg
view model =
    Theme.root
        (if model.dark then
            Theme.dark

         else
            Theme.light
        )
        [ Attr.style "min-height" "100vh", Attr.style "padding" "var(--astryx-space-lg)" ]
        [ Theme.stylesheet
        , Stack.view [ Stack.space "var(--astryx-space-lg)" ]
            []
            [ Heading.view Heading.h1 [] [ text "Astryx foundation" ]
            , nav [] [ text "Theme · Accessibility · Size · Status · Stack · Grid · Center · Text · Heading · Icon" ]
            , button [ Events.onClick ToggleTheme ] [ text "Toggle light/dark theme" ]
            , demo "Theme" [ Text.view Text.normal [] [ text "Semantic custom properties are inherited." ] ]
            , demo "Accessibility"
                [ Accessibility.liveRegion [] [ text "Polite live region" ]
                , Accessibility.visuallyHidden [ text "Screen-reader-only content" ]
                ]
            , demo "Size and status"
                [ code [] [ text (Size.toClass Size.Medium ++ " / " ++ Status.toString Status.Success) ] ]
            , demo "Stack"
                [ Stack.view [ Stack.horizontal, Stack.space "1rem", Stack.wrap ] [] [ tile "One", tile "Two", tile "Three" ] ]
            , demo "Grid"
                [ Grid.view [ Grid.minimumColumnWidth "10rem", Grid.space "1rem" ] [] [ tile "One", tile "Two", tile "Three" ] ]
            , demo "Center"
                [ Center.view [ Attr.style "min-height" "6rem", Attr.style "border" "1px solid var(--astryx-border)" ] [ text "Centered" ] ]
            , demo "Typography"
                [ Heading.view Heading.h3 [] [ text "Heading" ], Text.view Text.muted [] [ text "Muted supporting text" ] ]
            , demo "Icon" [ Icon.view (Icon.labelled "Favorite" (span [] [ text "★" ])) ]
            ]
        ]


demo : String -> List (Html msg) -> Html msg
demo title content =
    section [ Attr.id (Accessibility.id "section" title) ]
        [ Heading.view Heading.h2 [] [ text title ]
        , Stack.view [ Stack.space "0.75rem" ] [ Attr.style "margin-top" "0.75rem" ] content
        ]


tile : String -> Html msg
tile label =
    Center.view
        [ Attr.style "padding" "1rem"
        , Attr.style "background" "var(--astryx-surface)"
        , Attr.style "border" "1px solid var(--astryx-border)"
        , Attr.style "border-radius" "var(--astryx-radius-md)"
        ]
        [ text label ]
