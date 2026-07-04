module Astryx.ContextMenu exposing (Config, Item, view)

{-| Context menu positioned at application-supplied viewport coordinates.

@docs Config, Item, view

-}

import Astryx.DropdownMenu as DropdownMenu
import Astryx.Layer as Layer
import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode


{-| One context action.
-}
type alias Item msg =
    DropdownMenu.Item msg


{-| Context menu position and actions.
-}
type alias Config msg =
    { id : Layer.Id, layers : Layer.State, x : Float, y : Float, items : List (Item msg), onDismiss : Layer.Dismissal -> msg, attributes : List (Attribute msg) }


{-| Render the menu while its layer is open. Capture coordinates with an application `contextmenu` decoder.
-}
view : Config msg -> Html msg
view config =
    if Layer.isOpen config.id config.layers then
        div
            ([ Attr.class "astryx-menu astryx-context-menu"
             , Attr.attribute "role" "menu"
             , Attr.style "left" (String.fromFloat config.x ++ "px")
             , Attr.style "top" (String.fromFloat config.y ++ "px")
             , Attr.style "z-index" (Layer.zIndex config.id config.layers |> Maybe.withDefault 1000 |> String.fromInt)
             , Events.on "keydown" (escape config.onDismiss)
             ]
                ++ config.attributes
            )
            (List.indexedMap itemView config.items)

    else
        text ""


itemView : Int -> Item msg -> Html msg
itemView index item =
    button
        [ Attr.type_ "button"
        , Attr.attribute "role" "menuitem"
        , Attr.disabled item.disabled
        , Attr.tabindex
            (if index == 0 then
                0

             else
                -1
            )
        , Events.onClick item.onSelect
        ]
        [ text item.label ]


escape : (Layer.Dismissal -> msg) -> Decode.Decoder msg
escape toMsg =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Escape" then
                    Decode.succeed (toMsg Layer.Escape)

                else
                    Decode.fail "Not Escape"
            )
