# Critical UI elements

Astryx Core contains more than one hundred component families. The first Elm
release should maximize the number of real interfaces that can be built while
minimizing complex state and browser integration. Components are ranked by
usage breadth, dependency leverage, accessibility risk, and implementation
cost.

## Priority 0: foundations

These are required before component work because every later module consumes
them.

| Element | Proposed module | Why it is critical |
| --- | --- | --- |
| Theme and tokens | `Astryx.Theme` | Owns color, spacing, size, radius, shadow, motion, and typography values; enables light/dark themes without external CSS. |
| Shared attributes | internal module | Consistently combines generated styles, ARIA attributes, test IDs, and consumer attributes. It must define precedence rather than silently clobbering safety attributes. |
| Size and status types | `Astryx.Size`, `Astryx.Status` | Prevents every component from inventing incompatible variants. |
| Accessibility helpers | `Astryx.Accessibility` | Visually hidden content, generated IDs, ARIA relationships, reduced-motion handling, and keyboard decoding. |
| Layout primitives | `Astryx.Stack`, `Astryx.Grid`, `Astryx.Center` | Provides the composition layer used by forms, cards, navigation, and examples. Covers the original `HStack`, `VStack`, `Stack`, `Grid`, and `Center`. |
| Typography | `Astryx.Text`, `Astryx.Heading` | Establishes semantic text and heading usage before higher-level components embed typography. |
| Icon contract | `Astryx.Icon` | Accepts consumer-provided `Html msg` or an Elm-native icon value; avoids an icon package dependency. |

## Priority 1: minimum useful component library

These form the first publishable slice.

| Element | Proposed module | Required capabilities |
| --- | --- | --- |
| Button | `Astryx.Button` | Primary, secondary, ghost, destructive, disabled, loading, sizes, icon slots, native button types, link rendering. |
| Link | `Astryx.Link` | Safe target/relationship handling, external-link semantics, optional consumer navigation attributes. |
| Text input | `Astryx.Form.TextInput` | Controlled value, input type, disabled/read-only states, clear action, prefix/suffix slots. |
| Text area | `Astryx.Form.TextArea` | Controlled value, resize policy, disabled/read-only states. |
| Checkbox | `Astryx.Form.Checkbox` | Checked/indeterminate/disabled states and correctly associated label. |
| Radio group | `Astryx.Form.RadioGroup` | One controlled selection, group label, descriptions, validation, keyboard-friendly native controls. |
| Select | `Astryx.Form.Select` | Native select first; controlled selection, placeholder, disabled options, validation. |
| Field | `Astryx.Form.Field` | Label, description, required marker, error/status message, and generated ARIA wiring shared by every control. |
| Form layout | `Astryx.Form.Layout` | Predictable vertical and horizontal form composition. |
| Card | `Astryx.Card` | Surface, header/body/footer slots, selectable/clickable semantics kept explicit. |
| Badge and status | `Astryx.Badge`, `Astryx.StatusDot` | Compact status communication with text alternatives; color never carries meaning alone. |
| Banner | `Astryx.Banner` | Page-level information, success, warning, and error feedback with dismiss action. |
| Progress and spinner | `Astryx.Progress`, `Astryx.Spinner` | Determinate/indeterminate state, accessible labels, reduced motion. |
| Divider | `Astryx.Divider` | Semantic or decorative separation. |

This slice supports settings screens, authentication forms, CRUD forms,
dashboards, detail pages, and common empty/loading/error states without needing
an overlay system.

## Priority 2: application composition

Build after Priority 1 APIs and tokens are stable.

- `Astryx.Item` and `Astryx.List` for repeated structured content.
- `Astryx.Table` for semantic data tables, captions, alignment, and row states.
- `Astryx.Tabs` and `Astryx.SegmentedControl` for switching visible content.
- `Astryx.Breadcrumbs` and `Astryx.Pagination` for location and traversal.
- `Astryx.EmptyState` and `Astryx.Skeleton` for lifecycle states.
- `Astryx.AppShell`, `Astryx.TopNav`, and `Astryx.SideNav` for responsive app
  framing.
- `Astryx.Collapsible` for disclosure and accordion patterns.
- `Astryx.Toast` for queued, timed notifications with explicit Elm state.

## Priority 3: overlays and composite inputs

These have high accessibility and browser-behavior risk and need a shared layer
model before individual APIs are committed.

- Dialog and alert dialog
- Popover, tooltip, hover card, dropdown menu, and context menu
- Typeahead, selector, multi-selector, and command palette
- Calendar, date input, date range input, time input, and date-time input
- Lightbox and carousel

Overlay acceptance requires focus entry and restoration, Escape handling,
outside-click policy, stacking, scroll behavior, keyboard navigation, stable
ARIA relationships, and documented limitations. If Elm/browser APIs cannot
provide a behavior reliably without ports, the initial API must choose a native
HTML alternative or document the limitation; it must not hide JavaScript behind
the package.

## Priority 4: specialized and experimental components

Port only after real demand and stable lower-level primitives:

- Chat, power search, tree list, tokenizer, code block, markdown, resizable
  regions, and advanced overflow behavior.
- `../astryx/packages/lab` components such as Schedule, Stepper, CircularProgress,
  ChatReasoning, and ThreeD.
- Vega integration should remain a separate package because it conflicts with
  the core library's self-contained dependency goal.

## Explicitly deferred from the first release

- React-only concepts: providers, hooks, imperative handles, transitions, and
  component polymorphism via an `as` prop.
- CLI swizzling, templates, and theme code generation.
- Arbitrary runtime CSS parsing or StyleX compatibility.
- Exact source-level API parity. Behavioral and visual intent takes precedence
  over React-shaped naming.
