# Specialized package evaluation

Phase 7 evaluates Astryx Core and Lab components against demonstrated breadth,
the Elm-native dependency policy, accessibility risk, and whether the public API
can remain stable without a specific consuming application.

## Accepted into core

- `Astryx.Stepper` represents application-owned progress through a fixed
  workflow. It is semantic, dependency-free, and useful across onboarding,
  checkout, setup, and form flows.
- `Astryx.CircularProgress` is the compact form of the existing determinate
  progress primitive. It is dependency-free and exposes the same accessible
  value contract as a horizontal progress indicator.

Both components use existing theme tokens, honor reduced-motion behavior, and
have no loading, disabled, or error behavior beyond the states represented by
their APIs.

## Deferred pending usage evidence

Chat, ChatReasoning, power search, tree list, tokenizer, code block, Markdown,
resizable regions, advanced overflow, Schedule, and ThreeD remain deferred.
Their useful APIs depend on product-specific data models, parsing, browser
behavior, or rendering requirements. A proposal to add one must include at
least one concrete consumer, its interaction and accessibility requirements,
and evidence that existing core composition cannot reasonably implement it.

## Separate-package boundary

Charts, Vega, Markdown parsers, syntax highlighters, and 3D renderers must not
add their domain dependencies to the core package. Once a concrete consumer
exists, each integration should be considered as a separate Elm package that:

- depends on this package rather than expanding its dependency surface;
- contains only Elm dependencies and no ports or imported JavaScript runtime;
- owns its domain types, rendering contract, tests, and showcase;
- documents browser support and accessible non-visual alternatives.

No domain package is created speculatively: an empty package would commit a
name and compatibility surface without providing a testable artifact.
