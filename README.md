# Astryx for Elm

An Elm-native interpretation of the Astryx design system for building
consistent, accessible application interfaces.

> **Project status:** All seven planned phases complete.

## Goal

This project brings Astryx's visual language, component behavior, accessibility
standards, and theming model to Elm. It is an Elm library rather than a wrapper
around the React implementation: application behavior will be expressed with
Elm values, messages, commands, and subscriptions.

The core package will not require npm packages, imported JavaScript, ports, or
JavaScript-backed web components. It may use maintained Elm packages when they
provide a clear benefit and preserve Elm package guarantees.

## Available functionality

The package exposes foundations, controls, application structure, overlays,
composite inputs, and focused specialized components:

- semantic theme tokens with light and dark themes
- layout and typography foundations
- accessibility, size, status, and consumer-provided icon contracts
- buttons, links, forms, cards, status indicators, banners, and progress feedback
- lists, tables, tabs, pagination, breadcrumbs, and loading/empty states
- responsive application navigation plus collapsible and toast state machines
- dialogs, menus, tooltips, selectors, date/time inputs, and media composites
- stepper and circular progress components

Domain-heavy components remain subject to the package boundary and admission
criteria in the [specialized package evaluation](docs/specialized-packages.md).

## Minimal example

```elm
import Astryx.Heading as Heading
import Astryx.Stack as Stack
import Astryx.Theme as Theme
import Html exposing (text)

Theme.root Theme.light []
    [ Theme.stylesheet
    , Stack.view [ Stack.space "1rem" ] []
        [ Heading.view Heading.h1 [] [ text "Settings" ] ]
    ]
```

## Design principles

- **Elm-native behavior.** React context, hooks, and imperative APIs become
  explicit Elm data and state transitions.
- **Accessibility is part of the API.** Semantic HTML, accessible names,
  keyboard support, and visible focus are release requirements.
- **Semantic customization.** Themes expose design tokens and meaningful
  component variants instead of React or StyleX implementation details.
- **Composable APIs.** Components accept `Html msg` content where composition
  is useful and use opaque types where invalid states must be prevented.
- **No hidden runtime bridge.** Unsupported behavior is documented or replaced
  with a native HTML alternative rather than concealed behind JavaScript.

## Project plan

Development is split into independently testable phases:

1. Scope and contracts — complete.
2. Package, theme, accessibility, layout, and documentation foundations — complete.
3. Essential controls, forms, cards, and feedback — complete.
4. Application layout and navigation components — complete.
5. Dialogs and a shared overlay model — complete.
6. Composite selectors and date/time inputs — complete.
7. Specialized components based on demonstrated demand — complete.

The detailed [roadmap](docs/roadmap.md), [architecture](docs/architecture.md),
and [design plan](docs/README.md) define the acceptance gates for each phase.

## Package and browser support

The intended Elm package name is `hairizuanbinnoorazman/astryx-elm`. The initial
release targets current evergreen desktop and mobile browsers. Progressive
enhancement and native HTML are preferred; any narrower browser requirements
introduced by a component must be documented with that component.

## Reference implementation

[Astryx](https://github.com/astryxdesign/astryx) is the behavioral, visual,
accessibility, and naming reference. API parity is not a goal where React
patterns conflict with Elm architecture.
