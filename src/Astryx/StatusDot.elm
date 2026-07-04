module Astryx.StatusDot exposing (view)

{-| Status dots that always include an accessible text label.

@docs view

-}

import Astryx.Internal.Attributes as Attributes
import Astryx.Status as Status exposing (Status)
import Html exposing (Attribute, Html, span, text)
import Html.Attributes as Attr


{-| Render a colored dot with a required accessible label.
-}
view : Status -> String -> List (Attribute msg) -> Html msg
view status label attributes =
    span
        (Attributes.merge
            [ Attr.class "astryx-status-dot"
            , Attr.class ("astryx-status--" ++ Status.toString status)
            , Attr.attribute "role" "status"
            , Attr.attribute "aria-label" label
            ]
            attributes
        )
        [ span [ Attr.attribute "aria-hidden" "true" ] [ text "●" ] ]
