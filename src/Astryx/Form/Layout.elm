module Astryx.Form.Layout exposing (horizontal, vertical)

{-| Predictable form composition.

@docs horizontal, vertical

-}

import Astryx.Stack as Stack
import Html exposing (Attribute, Html)


{-| Stack fields vertically.
-}
vertical : List (Attribute msg) -> List (Html msg) -> Html msg
vertical =
    Stack.view [ Stack.vertical, Stack.space "var(--astryx-space-md)" ]


{-| Lay fields horizontally and allow wrapping.
-}
horizontal : List (Attribute msg) -> List (Html msg) -> Html msg
horizontal =
    Stack.view [ Stack.horizontal, Stack.space "var(--astryx-space-md)", Stack.wrap ]
