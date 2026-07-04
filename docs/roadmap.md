# Phased roadmap

Each phase ends in a coherent, testable artifact. Later phases should not begin
by widening the component inventory while earlier public APIs are still
changing substantially.

## Phase 1: scope and contracts

Status: complete.

- Establish the Elm-native dependency policy: community Elm packages are
  permitted; imported JavaScript and npm runtime packages are not.
- Inventory and prioritize Astryx components.
- Define Elm API, theming, accessibility, and testing conventions.
- Confirm the initial package name as `hairizuanbinnoorazman/astryx-elm` and
  target current evergreen desktop and mobile browsers. Publishing `elm.json`
  remains a Phase 2 action because exposed APIs are compatibility commitments.

Exit gate: complete. The root README and documents in this directory define the
accepted port boundary.

## Phase 2: package foundation

Status: complete.

- Create the Elm package and test project.
- Implement semantic theme tokens and a neutral light/dark theme.
- Implement shared attribute handling, accessibility helpers, sizes, status,
  typography, icons, and layout primitives.
- Create a showcase application with one route/section per module.
- Add docs generation, formatting, unit-test, and showcase-build checks.

Exit gate: consumers can build a themed static page using only exposed
foundation modules, and the package has no JavaScript/npm runtime dependency.

## Phase 3: essential controls and feedback

Status: complete.

Implement Priority 1 in dependency order:

1. Button, Link, Divider, Badge, StatusDot.
2. Field and FieldStatus.
3. TextInput, TextArea, Checkbox, RadioGroup, Select.
4. Form Layout, Card, Banner, Progress, Spinner.

Exit gate: showcase includes a complete validated form and a representative
settings/detail page; keyboard and accessible-name checks pass.

## Phase 4: application structure

Status: complete.

- Item/List, Table, Tabs, SegmentedControl.
- Breadcrumbs, Pagination, EmptyState, Skeleton.
- Collapsible and Toast with explicit Elm state machines.
- AppShell, TopNav, and SideNav with responsive examples.

Exit gate: a small CRUD-style application can be built entirely from the
library without custom structural components.

## Phase 5: shared overlay engine

- Specify layer state, IDs, z-order, dismissal, and focus lifecycle.
- Implement Dialog and AlertDialog first.
- Validate focus entry/restoration, Escape, outside click, nested layers, and
  scroll behavior in browser tests.
- Build Tooltip, Popover, DropdownMenu, and ContextMenu only on the validated
  layer contract.

Exit gate: overlay behavior meets the accessibility contract without ports or
external JavaScript. Unsupported browser behavior is documented explicitly.

## Phase 6: composite inputs

- Typeahead, Selector, MultiSelector, and CommandPalette.
- Calendar and date/time input families.
- Carousel and Lightbox.

Exit gate: keyboard interaction, selection state, validation, and mobile layout
are covered by unit and browser tests.

## Phase 7: specialized packages

Evaluate advanced Astryx Core and Lab components from usage evidence. Keep
charts, Vega integration, and other domain-heavy features outside the core
package so the dependency policy and API remain focused.

## Cross-phase release rules

- Every exposed value has Elm package documentation.
- Every interactive behavior has a test at the lowest effective level.
- Public state types are opaque when constructors could create invalid state.
- New dependencies require an architecture decision and documentation update.
- A component is not complete until its loading, disabled, error, keyboard,
  dark-theme, and reduced-motion behavior has been considered where applicable.
