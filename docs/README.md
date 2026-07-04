# Astryx for Elm: design plan

This directory defines the staged port of `../astryx` to an Elm-native UI
library. The port is Elm-native: it does not depend on a JavaScript runtime or
raw npm packages. Community Elm packages are allowed when they provide a clear
benefit and preserve Elm package guarantees.

Elm packages cannot literally have no dependencies: `elm/core` is mandatory,
and HTML components require `elm/html`. Interactive components may also need
official Elm packages such as `elm/browser`, `elm/json`, and `elm/time`. In this
plan, **Elm-native** means all application behavior is implemented in Elm. It
does not mean recreating maintained community Elm packages without cause.

## Documents

- [Critical UI elements](critical-ui-elements.md) identifies the minimum useful
  component set and explains its priority.
- [Architecture](architecture.md) maps Astryx's React design to Elm APIs and
  defines the dependency and accessibility boundaries.
- [Phased roadmap](roadmap.md) gives release gates and implementation order.
- [Specialized package evaluation](specialized-packages.md) records the Phase 7
  admission criteria and domain-package boundary.
- [Showcase templates session plan](showcase-templates-session-plan.md) evaluates
  the current library against the Login and Tools designs in the Astryx
  templates gallery, one template at a time.

## Reference projects

- `../astryx` is the behavioral, visual, accessibility, and naming reference.
- `../elm-bootstrap` demonstrates documented component modules, opaque option
  types, composable configuration, and explicit state for interactive widgets.
- `../elm-d3` demonstrates a small public surface, opaque domain types, pure
  Elm implementations, focused tests, and documentation validation with
  `elm make --docs`.

The target is an Elm interpretation of Astryx, not a mechanical React API
translation. React context and hooks become explicit Elm values and state
transitions. DOM-owning JavaScript behavior is implemented with Elm events,
commands, subscriptions, and standards-based HTML/CSS.
