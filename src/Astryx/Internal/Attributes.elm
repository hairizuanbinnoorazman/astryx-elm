module Astryx.Internal.Attributes exposing (merge)

import Html exposing (Attribute)


{-| Combine library defaults with consumer attributes. Consumer attributes are
last and therefore take precedence when the browser resolves duplicates.
-}
merge : List (Attribute msg) -> List (Attribute msg) -> List (Attribute msg)
merge generated consumer =
    generated ++ consumer
