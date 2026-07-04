module Astryx.Selector exposing (Config, Option, view)

{-| Searchable single-value selector.

@docs Config, Option, view

-}

import Astryx.Typeahead as Typeahead
import Html exposing (Attribute, Html)


{-| A selector option.
-}
type alias Option a =
    Typeahead.Option a


{-| Controlled selector configuration.
-}
type alias Config a msg =
    { key : String, label : String, query : String, options : List (Option a), open : Bool, active : Maybe Int, disabled : Bool, error : Maybe String, onQuery : String -> msg, onSelect : a -> msg, attributes : List (Attribute msg) }


{-| Render using the common autocomplete contract.
-}
view : Config a msg -> Html msg
view =
    Typeahead.view
