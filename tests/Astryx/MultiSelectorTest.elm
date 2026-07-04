module Astryx.MultiSelectorTest exposing (suite)

import Astryx.MultiSelector as MultiSelector
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.MultiSelector"
        [ test "removes already-selected keys" <|
            \_ ->
                MultiSelector.remaining [ option "a" ] [ option "a", option "b" ]
                    |> List.map .key
                    |> Expect.equal [ "b" ]
        ]


option : String -> MultiSelector.Option String
option key =
    { key = key, value = key, label = key, disabled = False }
