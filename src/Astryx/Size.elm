module Astryx.Size exposing (Size(..), toClass)

{-| Shared element sizes.

@docs Size, toClass

-}


{-| The three supported semantic sizes.
-}
type Size
    = Small
    | Medium
    | Large


{-| Convert a size to the class used by Astryx styles.
-}
toClass : Size -> String
toClass size =
    case size of
        Small ->
            "astryx-size-small"

        Medium ->
            "astryx-size-medium"

        Large ->
            "astryx-size-large"
