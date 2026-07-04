module Astryx.Pagination exposing (Config, view)

{-| Controlled pagination.

@docs Config, view

-}

import Html exposing (Attribute, Html, button, nav, span, text)
import Html.Attributes as Attr
import Html.Events as Events


{-| Pagination state. Pages are one-based.
-}
type alias Config msg =
    { page : Int, pageCount : Int, onChange : Int -> msg, attributes : List (Attribute msg) }


{-| Render previous/next controls and current page status.
-}
view : Config msg -> Html msg
view config =
    nav ([ Attr.class "astryx-pagination", Attr.attribute "aria-label" "Pagination" ] ++ config.attributes)
        [ button [ Attr.type_ "button", Attr.disabled (config.page <= 1), Attr.attribute "aria-label" "Previous page", Events.onClick (config.onChange (config.page - 1)) ] [ text "Previous" ]
        , span [ Attr.attribute "aria-current" "page" ] [ text ("Page " ++ String.fromInt config.page ++ " of " ++ String.fromInt config.pageCount) ]
        , button [ Attr.type_ "button", Attr.disabled (config.page >= config.pageCount), Attr.attribute "aria-label" "Next page", Events.onClick (config.onChange (config.page + 1)) ] [ text "Next" ]
        ]
