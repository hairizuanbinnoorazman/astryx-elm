# Showcase template notes

Implementation notes and intentional differences for the templates in
`showcase/src` live here. These notes distinguish reusable Astryx composition
from template-specific content and layout.

## Login Card

### States and interactions

- Email and password are controlled Elm state.
- Submitting invalid values reveals field-level errors connected through
  `Astryx.Form.Field`.
- A valid submission enters a disabled, loading state. Because this is a static
  showcase with no authentication service or simulated timer, **Complete demo
  request** deterministically resolves it and **Cancel and reset** returns to
  the initial state.
- Google and GitHub actions produce a visible live-region confirmation.
- All controls follow native document order and are keyboard operable.

### Astryx composition

The template uses `Center`, `Card`, `Stack`, `Heading`, `Text`, `Field`,
`TextInput`, `Button`, `Divider`, `Link`, `Icon`, `Accessibility`, and the
shared `Theme` frame in `Main.elm`.

### Local HTML and styles

- Native `form` provides submit semantics; this is page structure rather than
  a missing reusable component.
- Inline template layout sets the card's maximum width, full-width actions,
  page minimum height, separator alignment, and icon/text spacing.
- A local `.login-card` rule visually hides the `Field` labels to match the
  reference's placeholder-led controls while preserving their accessible names.
- `Divider` has no labeled-divider API. The labeled separator therefore uses
  two decorative `Divider` instances with visible muted text between them.
- The product and social-provider letter marks are local placeholder content. No branded
  image assets are included.

### Intentional differences

- Authentication and account-creation links do not leave the showcase.
- Loading completion is user-controlled and deterministic; no network request,
  JavaScript, port, or runtime dependency is implied.

### Playwright comparison

Desktop (1440 × 1000) and narrow (390 × 844) captures were compared with the
live `login-card` preview on 4 July 2026. The implementation follows the same
centered product mark, single card, email-first form, divider, Apple and Google
actions, sign-up prompt, and legal-copy hierarchy. Astryx theme colors,
typography, radii, and spacing intentionally replace the React template's exact
tokens. The gallery's narrow preview scales a desktop canvas inside its modal;
the showcase instead uses the available narrow width.

The first capture exposed that `Theme.root` was not applying CSS custom
properties through `Html.Attributes.style`. Theme tokens are now serialized as
one inline style attribute, with a focused regression test in
`tests/Astryx/ThemeTest.elm`.
