module Astryx.CommandPalette exposing (Command, Config, view)

{-| Modal command search built on the shared layer state.

@docs Command, Config, view

-}

import Astryx.Dialog as Dialog
import Astryx.Layer as Layer
import Astryx.Typeahead as Typeahead
import Html exposing (Attribute, Html)


{-| One command.
-}
type alias Command a =
    Typeahead.Option a


{-| Controlled palette configuration.
-}
type alias Config a msg =
    { id : Layer.Id, layers : Layer.State, label : String, query : String, commands : List (Command a), active : Maybe Int, onQuery : String -> msg, onSelect : a -> msg, onDismiss : Layer.Dismissal -> msg, attributes : List (Attribute msg) }


{-| Render the palette only while its layer is open.
-}
view : Config a msg -> Html msg
view config =
    Dialog.view
        { id = config.id
        , layers = config.layers
        , title = config.label
        , body = [ Typeahead.view { key = config.id, label = "Search commands", query = config.query, options = config.commands, open = True, active = config.active, disabled = False, error = Nothing, onQuery = config.onQuery, onSelect = config.onSelect, attributes = [] } ]
        , footer = []
        , onDismiss = config.onDismiss
        , attributes = config.attributes
        }
