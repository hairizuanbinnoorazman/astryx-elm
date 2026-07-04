module Astryx.Form.FieldStatus exposing (view)

{-| Validation and supporting messages for fields.

@docs view

-}

import Astryx.Status as Status exposing (Status)
import Html exposing (Attribute, Html, div)
import Html.Attributes as Attr


{-| Render a polite semantic field message.
-}
view : Status -> List (Attribute msg) -> List (Html msg) -> Html msg
view status attributes children =
    div ([ Attr.class "astryx-field-status", Attr.class ("astryx-status--" ++ Status.toString status), Attr.attribute "aria-live" "polite" ] ++ attributes) children
