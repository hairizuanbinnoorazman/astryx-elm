module Astryx.Text exposing (Tone, normal, muted, view)

{-| Semantic body text.

@docs Tone, normal, muted, view

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, p)
import Html.Attributes as Attr


{-| An opaque semantic text tone.
-}
type Tone
    = Normal
    | Muted


{-| Normal foreground text.
-}
normal : Tone
normal =
    Normal


{-| Lower-emphasis text.
-}
muted : Tone
muted =
    Muted


{-| Render a paragraph with a semantic tone.
-}
view : Tone -> List (Attribute msg) -> List (Html msg) -> Html msg
view tone attributes children =
    p
        (Attributes.merge
            [ Attr.class "astryx-text"
            , Attr.style "margin" "0"
            , Attr.style "color"
                (case tone of
                    Normal ->
                        "var(--astryx-text)"

                    Muted ->
                        "var(--astryx-text-muted)"
                )
            ]
            attributes
        )
        children
