# Overlay behavior and browser support

`Astryx.Layer` is the single source of truth for overlay IDs, ordering, and
dismissal. IDs are stable application keys. The list is bottom-to-top, z-order
increments by ten from 1000, only the top layer accepts dismissal, and closing
a layer also closes layers opened above it.

Dialog and AlertDialog use semantic `dialog` elements, labelled relationships,
`aria-modal`, initial `autofocus`, Escape handling, and a fixed scrolling
backdrop. Dialog allows backdrop dismissal; AlertDialog requires an explicit
choice. Tooltip, Popover, DropdownMenu, and ContextMenu share the same stack.

## Application responsibilities and limitations

Elm's virtual DOM cannot call the imperative `showModal()` or `focus()` browser
APIs without ports or JavaScript. In accordance with the dependency policy,
the package uses declarative `open` and `autofocus` instead. Current evergreen
browsers focus the autofocus control on insertion, but the package cannot trap
Tab within a dialog or restore focus to the opener after removal. Applications
requiring guaranteed focus trapping/restoration must do so at their integration
boundary; this package does not claim those two behaviors.

The application owns trigger events, opening/closing `Layer.State`, and focus
or hover timing. ContextMenu coordinates come from an application event decoder.
Floating panels use CSS anchor-relative positioning and do not collision-flip
at viewport edges. The fixed modal backdrop scrolls when dialog content exceeds
the viewport and prevents pointer interaction with underlying content; locking
document-body scrolling is not possible declaratively.
