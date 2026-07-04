module Astryx.DropdownMenu exposing (Config, Item, view)

{-| Action menu using native buttons and the shared layer stack.

@docs Config, Item, view

-}

import Astryx.Accessibility as Accessibility
import Astryx.Layer as Layer
import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode


{-| One menu action.
-}
type alias Item msg =
    { label : String, onSelect : msg, disabled : Bool }


{-| Dropdown trigger and actions.
-}
type alias Config msg =
    { id : Layer.Id, layers : Layer.State, trigger : List (Attribute msg) -> Html msg, items : List (Item msg), onDismiss : Layer.Dismissal -> msg, attributes : List (Attribute msg) }


{-| Render a menu. Native buttons retain activation and disabled semantics.
-}
view : Config msg -> Html msg
view config =
    let
        menuId =
            Accessibility.id "menu" config.id

        open =
            Layer.isOpen config.id config.layers
    in
    div ([ Attr.class "astryx-overlay-anchor", Events.on "keydown" (escape config.onDismiss) ] ++ config.attributes)
        [ config.trigger
            [ Attr.attribute "aria-haspopup" "menu"
            , Attr.attribute "aria-expanded"
                (if open then
                    "true"

                 else
                    "false"
                )
            , Attr.attribute "aria-controls" menuId
            ]
        , if open then
            div [ Attr.id menuId, Attr.class "astryx-menu", Attr.attribute "role" "menu", Attr.style "z-index" (Layer.zIndex config.id config.layers |> Maybe.withDefault 1000 |> String.fromInt) ] (List.indexedMap itemView config.items)

          else
            text ""
        ]


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
