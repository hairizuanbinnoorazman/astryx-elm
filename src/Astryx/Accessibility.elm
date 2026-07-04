module Astryx.Accessibility exposing (id, describedBy, labelledBy, liveRegion, visuallyHidden, key)

{-| Small accessibility building blocks for component authors and applications.

@docs id, describedBy, labelledBy, liveRegion, visuallyHidden, key

-}

import Html exposing (Attribute, Html, span)
import Html.Attributes as Attr
import Html.Events as Events
import Json.Decode as Decode


{-| Build a deterministic, DOM-safe identifier from a namespace and key.
The application should provide a key unique in the rendered page.
-}
id : String -> String -> String
id namespace value =
    "astryx-" ++ sanitize namespace ++ "-" ++ sanitize value


sanitize : String -> String
sanitize =
    String.toLower
        >> String.map
            (\character ->
                if Char.isAlphaNum character || character == '-' || character == '_' then
                    character

                else
                    '-'
            )


{-| Set `aria-describedby`, omitting empty identifiers.
-}
describedBy : List String -> Attribute msg
describedBy identifiers =
    Attr.attribute "aria-describedby" (identifiers |> List.filter ((/=) "") |> String.join " ")


{-| Set `aria-labelledby`, omitting empty identifiers.
-}
labelledBy : List String -> Attribute msg
labelledBy identifiers =
    Attr.attribute "aria-labelledby" (identifiers |> List.filter ((/=) "") |> String.join " ")


{-| Announce changing content politely to assistive technology.
-}
liveRegion : List (Attribute msg) -> List (Html msg) -> Html msg
liveRegion attributes children =
    span (Attr.attribute "aria-live" "polite" :: attributes) children


{-| Render content that remains available to assistive technology.
-}
visuallyHidden : List (Html msg) -> Html msg
visuallyHidden children =
    span [ Attr.class "astryx-visually-hidden" ] children


{-| Decode a keyboard event into its `KeyboardEvent.key` value.
-}
key : (String -> msg) -> Attribute msg
key toMessage =
    Events.on "keydown" (Decode.map toMessage (Decode.field "key" Decode.string))
