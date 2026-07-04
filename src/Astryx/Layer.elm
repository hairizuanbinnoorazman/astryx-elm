module Astryx.Layer exposing (State, Id, Kind(..), Dismissal(..), init, open, close, dismiss, isOpen, top, zIndex, layers)

{-| Shared, deterministic overlay state. Keep one `State` in the application and
use stable IDs for every overlay. Opening an existing ID moves it to the top.

@docs State, Id, Kind, Dismissal, init, open, close, dismiss, isOpen, top, zIndex, layers

-}


{-| Stable layer identifier.
-}
type alias Id =
    String


{-| Overlay behavior category.
-}
type Kind
    = Modal
    | NonModal


{-| The user action requesting dismissal.
-}
type Dismissal
    = Escape
    | OutsideClick
    | Action


type alias Entry =
    { id : Id, kind : Kind }


{-| Opaque stack, ordered bottom to top.
-}
type State
    = State (List Entry)


{-| Empty layer stack.
-}
init : State
init =
    State []


{-| Open a layer and place it above all existing layers.
-}
open : Kind -> Id -> State -> State
open kind id (State entries) =
    State (List.filter (\entry -> entry.id /= id) entries ++ [ { id = id, kind = kind } ])


{-| Close a layer by ID. Descendant layers above a modal are also removed.
-}
close : Id -> State -> State
close id (State entries) =
    State (closeEntries id entries)


closeEntries : Id -> List Entry -> List Entry
closeEntries id entries =
    case entries of
        [] ->
            []

        entry :: rest ->
            if entry.id == id then
                []

            else
                entry :: closeEntries id rest


{-| Apply a dismissal request only when the target is topmost.
-}
dismiss : Dismissal -> Id -> State -> State
dismiss _ id state =
    if top state == Just id then
        close id state

    else
        state


{-| Test whether an ID is in the stack.
-}
isOpen : Id -> State -> Bool
isOpen id (State entries) =
    List.any (\entry -> entry.id == id) entries


{-| Return the topmost layer ID.
-}
top : State -> Maybe Id
top (State entries) =
    List.reverse entries |> List.head |> Maybe.map .id


{-| Compute a stable layer z-index in steps of ten, starting at 1000.
-}
zIndex : Id -> State -> Maybe Int
zIndex id (State entries) =
    entries
        |> List.indexedMap Tuple.pair
        |> List.filter (\( _, entry ) -> entry.id == id)
        |> List.head
        |> Maybe.map (\( index, _ ) -> 1000 + index * 10)


{-| IDs ordered bottom to top.
-}
layers : State -> List Id
layers (State entries) =
    List.map .id entries
