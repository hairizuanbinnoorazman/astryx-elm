module Astryx.Carousel exposing (Config, Slide, normalize, view)

{-| Controlled carousel.

@docs Config, Slide, normalize, view

-}

import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| One labelled slide.
-}
type alias Slide msg =
    { label : String, content : List (Html msg) }


{-| Controlled carousel configuration.
-}
type alias Config msg =
    { label : String, slides : List (Slide msg), current : Int, previousLabel : String, nextLabel : String, onChange : Int -> msg, attributes : List (Attribute msg) }


{-| Wrap an index into a collection.
-}
normalize : Int -> Int -> Int
normalize count index =
    if count <= 0 then
        0

    else
        modBy count index


{-| Render only the current slide.
-}
view : Config msg -> Html msg
view config =
    let
        count =
            List.length config.slides

        current =
            normalize count config.current

        shown =
            List.drop current config.slides |> List.head
    in
    div ([ Attr.class "astryx-carousel", Attr.attribute "role" "region", Attr.attribute "aria-roledescription" "carousel", Attr.attribute "aria-label" config.label ] ++ config.attributes)
        [ div [ Attr.class "astryx-carousel__viewport", Attr.attribute "aria-live" "polite" ]
            (shown |> Maybe.map (\slide -> [ div [ Attr.attribute "role" "group", Attr.attribute "aria-roledescription" "slide", Attr.attribute "aria-label" (slide.label ++ " (" ++ String.fromInt (current + 1) ++ " of " ++ String.fromInt count ++ ")") ] slide.content ]) |> Maybe.withDefault [])
        , div [ Attr.class "astryx-carousel__controls" ]
            [ button [ Attr.type_ "button", Attr.disabled (count < 2), Attr.attribute "aria-label" config.previousLabel, Events.onClick (config.onChange (normalize count (current - 1))) ] [ text "Previous" ]
            , button [ Attr.type_ "button", Attr.disabled (count < 2), Attr.attribute "aria-label" config.nextLabel, Events.onClick (config.onChange (normalize count (current + 1))) ] [ text "Next" ]
            ]
        ]
