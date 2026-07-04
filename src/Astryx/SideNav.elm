module Astryx.SideNav exposing (Item, Config, view)

{-| Secondary application navigation.

@docs Item, Config, view

-}

import Html exposing (Attribute, Html, a, li, nav, text, ul)
import Html.Attributes as Attr


{-| One navigation destination.
-}
type alias Item =
    { label : String, url : String, current : Bool }


{-| Side navigation configuration.
-}
type alias Config msg =
    { label : String, items : List Item, attributes : List (Attribute msg) }


{-| Render a labelled side navigation landmark.
-}
view : Config msg -> Html msg
view config =
    nav ([ Attr.class "astryx-side-nav", Attr.attribute "aria-label" config.label ] ++ config.attributes)
        [ ul [] (List.map itemView config.items) ]


itemView : Item -> Html msg
itemView item =
    li []
        [ a
            ([ Attr.href item.url ]
                ++ (if item.current then
                        [ Attr.attribute "aria-current" "page" ]

                    else
                        []
                   )
            )
            [ text item.label ]
        ]
