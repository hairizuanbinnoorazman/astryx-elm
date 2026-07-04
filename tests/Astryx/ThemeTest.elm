module Astryx.ThemeTest exposing (suite)

import Astryx.Theme as Theme
import Expect
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute)


suite : Test
suite =
    describe "Theme"
        [ test "serializes theme tokens as CSS custom properties" <|
            \_ ->
                Theme.root Theme.light [ Attr.id "root" ] []
                    |> Query.fromHtml
                    |> Query.has
                        [ attribute
                            (Attr.attribute "style"
                                "color-scheme:light;--astryx-background:#f8fafc;--astryx-surface:#ffffff;--astryx-surface-raised:#ffffff;--astryx-text:#172033;--astryx-text-muted:#5f6b7c;--astryx-border:#d7dde7;--astryx-focus:#2563eb;--astryx-primary:#3157d5;--astryx-on-primary:#ffffff;--astryx-info:#2563eb;--astryx-success:#16803c;--astryx-warning:#a15c00;--astryx-danger:#c52d3a;--astryx-space-xs:0.25rem;--astryx-space-sm:0.5rem;--astryx-space-md:1rem;--astryx-space-lg:1.5rem;--astryx-space-xl:2rem;--astryx-radius-sm:0.25rem;--astryx-radius-md:0.5rem;--astryx-radius-lg:0.75rem;--astryx-radius-round:9999px;--astryx-shadow-low:0 1px 2px rgb(0 0 0 / 0.08);--astryx-shadow-medium:0 4px 12px rgb(0 0 0 / 0.12);--astryx-shadow-high:0 12px 32px rgb(0 0 0 / 0.18);--astryx-motion-fast:100ms;--astryx-motion-normal:180ms;--astryx-motion-slow:300ms;--astryx-easing:cubic-bezier(0.2, 0, 0, 1);--astryx-font:Inter, ui-sans-serif, system-ui, sans-serif;--astryx-font-mono:ui-monospace, SFMono-Regular, monospace"
                            )
                        ]
        ]
