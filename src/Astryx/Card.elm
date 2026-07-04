module Astryx.Card exposing (Config, view)

{-| Composable content surfaces.

@docs Config, view

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, article, div)
import Html.Attributes as Attr


{-| Card content slots and root attributes.
-}
type alias Config msg =
    { header : List (Html msg), body : List (Html msg), footer : List (Html msg), attributes : List (Attribute msg) }


{-| Render a card as an article.
-}
view : Config msg -> Html msg
view config =
    article (Attributes.merge [ Attr.class "astryx-card" ] config.attributes)
        ((if List.isEmpty config.header then
            []

          else
            [ div [ Attr.class "astryx-card__header" ] config.header ]
         )
            ++ [ div [ Attr.class "astryx-card__body" ] config.body ]
            ++ (if List.isEmpty config.footer then
                    []

                else
                    [ div [ Attr.class "astryx-card__footer" ] config.footer ]
               )
        )
