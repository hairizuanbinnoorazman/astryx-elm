# Showcase templates session plan

## Goal

Test whether the current Elm library can reproduce selected designs from the
[Astryx templates gallery](https://astryx.atmeta.com/templates) in the showcase.
Work on one template at a time so each result gives useful evidence about the
library before the next design is started.

This session covers the gallery's Login section first, followed by its Tools
section. It is an evaluation of the existing public library API, not a request
for pixel-identical React template ports.

The remaining gallery sections are tracked below as subsequent sessions. They
are not excluded from the showcase effort; Login and Tools are the first slice.

## Reference set

### Login

1. **Login Card** — centered card with social sign-in and an email form.
2. **Login Split** — split-screen login with a form and cover image.
3. **Login SSO** — email-based SSO provider detection.

### Tools

4. **File Explorer** — column-based browser inspired by macOS Finder.
5. **IDE** — file explorer, tabbed editor, terminal, and properties sidebar;
   panels are collapsible and resizable in the reference.
6. **Page Editor** — block-based page builder with configuration sidebar and
   live preview.

## Complete gallery backlog

After this session, continue one section at a time in the following order. The
order moves from broad existing component coverage toward more specialized
content, media, and chat behavior.

### Session 2: Table

1. **Grouped Table** — grouped data with collapsible status sections, search,
   and a resizable detail panel.
2. **Searchable Table** — table page with search filtering and an action
   toolbar.

Primary library tests: `Table`, `Collapsible`, `Typeahead` or
`CommandPalette`, `Badge`, `StatusDot`, `Pagination`, and detail-panel layout.
Power-search syntax and resizing should be recorded as separate capability
questions rather than assumed to exist.

### Session 3: Form

1. **Checkout Form** — billing, delivery, payment, order summary, and validation.
2. **Contact Form** — lead-capture form with toggles, dropdowns, and a primary
   action.
3. **Two-column Form** — hero and form-card data-collection layout.

Primary library tests: the full `Astryx.Form.*` family, `Card`, `Grid`, `Stack`,
`Button`, `Banner`, and responsive validation. Payment submission remains a
showcase state model, not real payment handling.

### Session 4: Settings

1. **Settings Form** — scrolling account, password, and advanced settings.
2. **Settings Panels** — navigation-switched panels, inline row editing, and
   privacy controls.

Primary library tests: form composition, `SideNav`, `Tabs`, `Item`, `Dialog`,
`AlertDialog`, `Toast`, and dirty/saved/error state management.

### Session 5: Content

1. **Card Grid** — categorized, filterable component cards.
2. **Documentation Catalog** — documentation landing page and category grid.
3. **Documentation Design** — component preview, guidance, practices table, and
   examples.
4. **Documentation Technical** — installation, assistance prompt, theming, and
   next steps.
5. **Order Detail** — order timeline and line items.
6. **Product Detail** — image gallery and collapsible product information.

Primary library tests: `Card`, `Grid`, `Tabs`, `SegmentedControl`, `Table`,
`Stepper`, `Collapsible`, `Breadcrumbs`, `Lightbox`, and typography. Code and
markdown presentation may remain semantic local showcase content unless reuse
evidence justifies specialized modules.

### Session 6: AI Chat

1. **AI Chat Conversation** — messages, tool calls, system content, code,
   multi-bubble grouping, and artifact preview.
2. **AI Chat Landing** — greeting, composer, and category toggles.

Primary library tests: application shells, `Item`, `Card`, `TextArea`,
`Button`, `Collapsible`, `Progress`, and accessible live updates. Streaming,
markdown, code blocks, and resizable artifacts are specialized capability
questions and must not be implied by a static mock.

### Session 7: Gallery

1. **Centered Hero** — centered copy and actions over a wide hero image.
2. **Classic Gallery** — responsive gallery with category filters.
3. **Gallery Hero** — hero content over a three-image grid.
4. **Mixed Gallery** — masonry-style mixed-size images.
5. **Product Gallery** — product cards with images and prices.
6. **Side Gallery** — copy and actions beside an image collage.

Primary library tests: `Grid`, `Center`, `Stack`, `Card`, `Tabs`, `Button`,
`Lightbox`, and responsive image treatment. Image loading, alt text, aspect
ratios, and layout shift are required acceptance checks.

### Session 8: Shell

1. **Shell Nav** — top and side navigation, application menus, command search,
   file tree, and tabbed editor surface.
2. **Side Nav** — collapsible conversation navigation with grouped workspaces
   and status indicators.
3. **Top Nav** — centered commerce navigation with mega menus and checkout
   action.

Primary library tests: `AppShell`, `TopNav`, `SideNav`, `DropdownMenu`,
`CommandPalette`, `Tabs`, `StatusDot`, and responsive navigation. These should
follow Tools because they can reuse the shell and panel findings instead of
building a second set of local workarounds.

### Full-program checkpoint

After every session:

- add its results to the same capability matrix;
- promote repeated gaps to a library proposal only after at least two examples
  demonstrate the need;
- run `make check` and perform desktop, narrow, light, dark, and keyboard checks;
- update the backlog if the live gallery adds, removes, or renames templates.

The current gallery therefore represents 30 planned showcase templates across
eight sessions: 6 in this Login/Tools session and 24 in the subsequent backlog.

The descriptions above are the observable contract from the gallery. Before
implementing each item, capture its current preview at desktop and narrow
viewport sizes and record its states, hierarchy, and interactions. This avoids
guessing from the summary card when the reference changes.

## Working rules

- Add templates to the existing `showcase` application; do not expose template
  code as new package modules during this session.
- Compose the public `Astryx.*` APIs first. Native `Html` and local styles are
  allowed only for page content and layout that is not a reusable component.
- Record every workaround. If the same workaround appears in two templates,
  treat it as evidence for a library API change rather than copying it again.
- Do not add JavaScript, ports, or npm runtime dependencies. A reference
  interaction that cannot be implemented reliably within the package boundary
  must be reduced explicitly and documented.
- Keep each template as a separate showcase module with its own model, message,
  update, and view boundary. Keep showcase navigation in `Main.elm`.
- Complete and verify one template before beginning the next.

## Session sequence

### 0. Prepare the showcase harness

- Add simple showcase navigation for a template index and one active template.
- Establish a shared full-page template frame using `Theme.root` and
  `Theme.stylesheet`.
- Decide where reference notes and intentional differences live beside each
  example.
- Confirm the untouched baseline with `make check`.

Exit: a blank template route/selection can be opened directly and at narrow and
desktop widths without changing the library API.

### 1. Build Login Card

Use `Center`, `Card`, `Stack`, `Heading`, `Text`, `Field`, `TextInput`, `Button`,
`Divider`, `Link`, `Icon`, and `Theme`. Implement controlled email/password
state, disabled/loading submission states, social sign-in actions, and visible
validation feedback.

Evaluate:

- whether `Card` and layout primitives express the target width and spacing;
- whether buttons can represent full-width and icon-leading actions cleanly;
- whether password and email fields have the required semantics;
- keyboard order, accessible labels, errors, dark theme, and narrow layout.

Exit: the card is a complete keyboard-usable login flow mock, and all custom
HTML/CSS outside Astryx modules is listed.

### 2. Build Login Split

Reuse the Login Card form behavior, then add the responsive two-column shell,
brand/content panel, cover image treatment, and narrow-screen collapse order.
Use `Grid`, `Stack`, and existing typography and form modules before adding
local layout styles.

Evaluate:

- whether `Grid` supports the split proportions and breakpoint behavior;
- whether decorative media can remain correctly hidden from assistive tech;
- whether the form can be reused without duplicating its state and validation;
- overflow and minimum-height behavior at narrow and short viewports.

Exit: desktop and narrow layouts work with a documented media fallback and no
regression to Login Card.

### 3. Build Login SSO

Model explicit states: initial email entry, detecting, provider found, no
provider, and error. Compose `Field`, `TextInput`, `Button`, `Spinner`, `Banner`,
`Card`, `Stack`, and `Accessibility.liveRegion`.

Evaluate:

- whether feedback components communicate asynchronous state coherently;
- focus placement and announcement when detection completes;
- whether the existing input/button APIs support submit and retry flows;
- whether any reusable authentication pattern belongs in documentation rather
  than the component library.

Exit: every state is reachable deterministically in the showcase and is usable
without relying on color or animation.

### 4. Login checkpoint

- Run formatting, tests, documentation generation, and showcase build.
- Review all three examples at desktop and narrow widths, light and dark themes,
  and keyboard-only operation.
- Write a short capability matrix: supported directly, supported by composition,
  locally styled, or blocked by a missing primitive.
- Fix general library defects only when the login examples prove the issue and
  add focused tests for any public API change.

Exit: login findings are recorded before tool-template work starts.

### 5. Build File Explorer

Start with a static but selectable column browser. Use `AppShell`, `SideNav`,
`Breadcrumbs`, `Item`, `Stack`, `Grid`, `Icon`, `Text`, `Button`, and
`ContextMenu` where their semantics fit. Represent folder selection and column
contents in Elm data.

Evaluate:

- whether `Item` can represent files, folders, metadata, and selected state;
- keyboard traversal and focus behavior across columns;
- horizontal overflow on narrow screens;
- the absence of a tree/list-browser primitive and whether native semantics are
  sufficient;
- resizable panes separately from the basic browsing experience.

Exit: selection and navigation work without a mouse. Resizing may be an explicit
documented gap; it must not be simulated with inaccessible drag-only behavior.

### 6. Build IDE

Compose the proven explorer structure with `Tabs`, `Collapsible`, `AppShell`,
`SideNav`, `TopNav`, `DropdownMenu`, `CommandPalette`, and layout primitives.
Use semantic `pre`/`code` content locally because the library does not claim a
code-editor component.

Evaluate:

- controlled tab selection, panel collapse, and command/menu state;
- whether shell APIs permit the required multi-panel workspace;
- focus order across explorer, editor, terminal, and properties regions;
- which behaviors require future primitives: resize handles, tree navigation,
  editable code, or advanced overflow.

Exit: the workspace demonstrates library composition honestly; editor and
resizing limitations are labelled rather than presented as production-ready.

### 7. Build Page Editor

Model a small list of selectable page blocks and explicit configuration state.
Compose `AppShell`, `SideNav`, `Tabs`, `Card`, `Item`, form controls,
`SegmentedControl`, `Popover`, and layout primitives. Keep drag-and-drop out of
scope unless it can meet keyboard and accessibility requirements.

Evaluate:

- selection synchronization between block list, settings, and preview;
- suitability of current form controls for property editing;
- responsive behavior of configuration and preview panes;
- whether reorder, resize, or canvas interactions expose a justified future
  package boundary.

Exit: selecting and editing supported block properties updates the preview; any
unsupported authoring interactions are documented.

### 8. Final tools checkpoint

- Repeat the build, responsive, theme, and keyboard checks used for Login.
- Extend the capability matrix with the three Tools examples.
- Classify gaps as showcase-only layout, missing general primitive, specialized
  package candidate, or intentionally unsupported browser behavior.
- Turn only evidence-backed general defects into library changes and tests.
- Update showcase documentation with how to open every template and the known
  limitations.

Exit: all six examples either pass their stated exit criteria or have a precise
blocked finding with the smallest missing capability identified.

## Expected capability map

| Area | Current evidence | Session expectation |
| --- | --- | --- |
| Login forms | Field, text input, button, card, feedback, and layout modules exist | High coverage through direct composition |
| Split authentication layout | Grid, Center, Stack, theme, and typography exist | Mostly composition; responsive media layout needs validation |
| SSO states | Spinner, Banner, accessibility helpers, and controlled Elm state exist | High behavioral coverage without a real identity provider |
| File browser | Shell, navigation, item, menu, and layout modules exist | Static/selectable browser is plausible; tree and resizing are gaps to test |
| IDE | Tabs, collapsible panels, menus, command palette, and shell modules exist | Workspace mock is plausible; editor and resize behavior are out of core scope |
| Page editor | Forms, cards, items, tabs, popovers, and shell modules exist | Property editing is plausible; canvas and drag/reorder need explicit limits |

## Definition of done for this session

- Login Card, Login Split, and Login SSO are attempted in that order before any
  Tools template.
- File Explorer, IDE, and Page Editor are then attempted in that order.
- Each template has an independently understandable Elm state model and can be
  reached from the showcase.
- Each completed template is checked at narrow and desktop widths, in light and
  dark themes, and with keyboard-only use.
- `make check` passes after each completed slice.
- The final capability matrix distinguishes successful public API composition
  from local styling and genuinely missing components.
- No new public component is added solely to make one screenshot match.
