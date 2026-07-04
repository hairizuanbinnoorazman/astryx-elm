module Astryx.Status exposing (Status(..), toString)

{-| Shared semantic statuses.

@docs Status, toString

-}


{-| A status whose meaning is never conveyed by color alone.
-}
type Status
    = Neutral
    | Info
    | Success
    | Warning
    | Danger


{-| Return the stable lowercase status name.
-}
toString : Status -> String
toString status =
    case status of
        Neutral ->
            "neutral"

        Info ->
            "info"

        Success ->
            "success"

        Warning ->
            "warning"

        Danger ->
            "danger"
