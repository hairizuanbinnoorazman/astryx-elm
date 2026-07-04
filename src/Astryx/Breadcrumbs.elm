module Astryx.Breadcrumbs exposing (Item, view)

{-| Breadcrumb navigation.

@docs Item, view

-}

import Html exposing (Attribute, Html, a, li, nav, ol, span, text)
import Html.Attributes as Attr


{-| A breadcrumb. The final item should use `Nothing` for its URL.
-}
type alias Item =
    { label : String, url : Maybe String }


{-| Render a labelled breadcrumb navigation landmark.
-}
view : List (Attribute msg) -> List Item -> Html msg
view attributes items =
    nav ([ Attr.class "astryx-breadcrumbs", Attr.attribute "aria-label" "Breadcrumb" ] ++ attributes)
        [ ol [] (List.indexedMap (itemView (List.length items)) items) ]


itemView : Int -> Int -> Item -> Html msg
itemView count index item =
    li []
        ((if index > 0 then
            [ span [ Attr.attribute "aria-hidden" "true" ] [ text "/" ] ]

          else
            []
         )
            ++ [ case item.url of
                    Just url ->
                        a [ Attr.href url ] [ text item.label ]

                    Nothing ->
                        span
                            [ Attr.attribute "aria-current"
                                (if index == count - 1 then
                                    "page"

                                 else
                                    "false"
                                )
                            ]
                            [ text item.label ]
               ]
        )
