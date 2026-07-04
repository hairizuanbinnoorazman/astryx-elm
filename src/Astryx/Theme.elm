module Astryx.Theme exposing
    ( Theme, Colors, Spacing, Radii, Shadows, Motion, Typography
    , light, dark, root, stylesheet
    )

{-| Semantic design tokens and neutral built-in themes.

@docs Theme, Colors, Spacing, Radii, Shadows, Motion, Typography
@docs light, dark, root, stylesheet

-}

import Astryx.Internal.Attributes as Attributes
import Html exposing (Attribute, Html, div, node, text)
import Html.Attributes as Attr


{-| Semantic colors used by components.
-}
type alias Colors =
    { background : String
    , surface : String
    , surfaceRaised : String
    , text : String
    , textMuted : String
    , border : String
    , focus : String
    , primary : String
    , onPrimary : String
    , info : String
    , success : String
    , warning : String
    , danger : String
    }


{-| Layout spacing tokens.
-}
type alias Spacing =
    { xsmall : String, small : String, medium : String, large : String, xlarge : String }


{-| Border radius tokens.
-}
type alias Radii =
    { small : String, medium : String, large : String, round : String }


{-| Elevation tokens.
-}
type alias Shadows =
    { low : String, medium : String, high : String }


{-| Animation tokens. The stylesheet honors reduced motion.
-}
type alias Motion =
    { fast : String, normal : String, slow : String, easing : String }


{-| Font family and weight tokens.
-}
type alias Typography =
    { fontFamily : String, monoFamily : String, normalWeight : Int, mediumWeight : Int, boldWeight : Int }


{-| A complete semantic theme.
-}
type alias Theme =
    { name : String
    , colors : Colors
    , spacing : Spacing
    , radii : Radii
    , shadows : Shadows
    , motion : Motion
    , typography : Typography
    }


base : String -> Colors -> Theme
base name colors =
    { name = name
    , colors = colors
    , spacing = { xsmall = "0.25rem", small = "0.5rem", medium = "1rem", large = "1.5rem", xlarge = "2rem" }
    , radii = { small = "0.25rem", medium = "0.5rem", large = "0.75rem", round = "9999px" }
    , shadows = { low = "0 1px 2px rgb(0 0 0 / 0.08)", medium = "0 4px 12px rgb(0 0 0 / 0.12)", high = "0 12px 32px rgb(0 0 0 / 0.18)" }
    , motion = { fast = "100ms", normal = "180ms", slow = "300ms", easing = "cubic-bezier(0.2, 0, 0, 1)" }
    , typography = { fontFamily = "Inter, ui-sans-serif, system-ui, sans-serif", monoFamily = "ui-monospace, SFMono-Regular, monospace", normalWeight = 400, mediumWeight = 500, boldWeight = 700 }
    }


{-| Neutral light theme.
-}
light : Theme
light =
    base "light"
        { background = "#f8fafc"
        , surface = "#ffffff"
        , surfaceRaised = "#ffffff"
        , text = "#172033"
        , textMuted = "#5f6b7c"
        , border = "#d7dde7"
        , focus = "#2563eb"
        , primary = "#3157d5"
        , onPrimary = "#ffffff"
        , info = "#2563eb"
        , success = "#16803c"
        , warning = "#a15c00"
        , danger = "#c52d3a"
        }


{-| Neutral dark theme.
-}
dark : Theme
dark =
    base "dark"
        { background = "#10141d"
        , surface = "#191f2b"
        , surfaceRaised = "#222a38"
        , text = "#f3f6fb"
        , textMuted = "#aeb8c8"
        , border = "#3b4556"
        , focus = "#7aa2ff"
        , primary = "#89a6ff"
        , onPrimary = "#111827"
        , info = "#70a5ff"
        , success = "#55c981"
        , warning = "#f1b44c"
        , danger = "#ff7b86"
        }


{-| Wrap content in a theme root. Consumer attributes take precedence.
-}
root : Theme -> List (Attribute msg) -> List (Html msg) -> Html msg
root theme attributes children =
    div (Attributes.merge (variables theme) attributes) children


variables : Theme -> List (Attribute msg)
variables theme =
    [ Attr.class "astryx-theme"
    , Attr.attribute "data-astryx-theme" theme.name
    , Attr.style "color-scheme"
        (if theme.name == "dark" then
            "dark"

         else
            "light"
        )
    , token "background" theme.colors.background
    , token "surface" theme.colors.surface
    , token "surface-raised" theme.colors.surfaceRaised
    , token "text" theme.colors.text
    , token "text-muted" theme.colors.textMuted
    , token "border" theme.colors.border
    , token "focus" theme.colors.focus
    , token "primary" theme.colors.primary
    , token "on-primary" theme.colors.onPrimary
    , token "info" theme.colors.info
    , token "success" theme.colors.success
    , token "warning" theme.colors.warning
    , token "danger" theme.colors.danger
    , token "space-xs" theme.spacing.xsmall
    , token "space-sm" theme.spacing.small
    , token "space-md" theme.spacing.medium
    , token "space-lg" theme.spacing.large
    , token "space-xl" theme.spacing.xlarge
    , token "radius-sm" theme.radii.small
    , token "radius-md" theme.radii.medium
    , token "radius-lg" theme.radii.large
    , token "radius-round" theme.radii.round
    , token "shadow-low" theme.shadows.low
    , token "shadow-medium" theme.shadows.medium
    , token "shadow-high" theme.shadows.high
    , token "motion-fast" theme.motion.fast
    , token "motion-normal" theme.motion.normal
    , token "motion-slow" theme.motion.slow
    , token "easing" theme.motion.easing
    , token "font" theme.typography.fontFamily
    , token "font-mono" theme.typography.monoFamily
    ]


token : String -> String -> Attribute msg
token name value =
    Attr.style ("--astryx-" ++ name) value


{-| Package CSS as an Elm node. Render it once per document.
-}
stylesheet : Html msg
stylesheet =
    node "style" [ Attr.attribute "data-astryx-styles" "foundation" ] [ text css ]


css : String
css =
    """
.astryx-theme{box-sizing:border-box;min-height:100%;background:var(--astryx-background);color:var(--astryx-text);font-family:var(--astryx-font);line-height:1.5}
.astryx-theme *,.astryx-theme *::before,.astryx-theme *::after{box-sizing:inherit}
.astryx-theme :focus-visible{outline:2px solid var(--astryx-focus);outline-offset:2px}
.astryx-visually-hidden{position:absolute!important;width:1px!important;height:1px!important;padding:0!important;margin:-1px!important;overflow:hidden!important;clip:rect(0,0,0,0)!important;white-space:nowrap!important;border:0!important}
.astryx-icon{display:inline-flex;align-items:center;justify-content:center;line-height:0}
@media(prefers-reduced-motion:reduce){.astryx-theme,.astryx-theme *,.astryx-theme *::before,.astryx-theme *::after{scroll-behavior:auto!important;animation-duration:0.01ms!important;animation-iteration-count:1!important;transition-duration:0.01ms!important}}
"""
