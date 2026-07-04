module Astryx.Link exposing (Option, external, newTab, view)

{-| Links with safe new-window and external-link semantics.

@docs Option, external, newTab, view

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, a, span, text)
import Html.Attributes as Attr


{-| Optional link behavior.
-}
type Option
    = External
    | NewTab


{-| Add an external-link announcement.
-}
external : Option
external =
    External


{-| Open in a new tab with a safe relationship.
-}
newTab : Option
newTab =
    NewTab


{-| Render a link to the given URL.
-}
view : String -> List Option -> List (Attribute msg) -> List (Html msg) -> Html msg
view url options attributes children =
    let
        externalLink =
            List.member External options

        generated =
            [ Attr.class "astryx-link", Attr.href url ]
                ++ (if List.member NewTab options then
                        [ Attr.target "_blank", Attr.rel "noopener noreferrer" ]

                    else
                        []
                   )
    in
    a (Attributes.merge generated attributes)
        (children
            ++ (if externalLink then
                    [ span [ Attr.class "astryx-visually-hidden" ] [ text " (external link)" ] ]

                else
                    []
               )
        )
