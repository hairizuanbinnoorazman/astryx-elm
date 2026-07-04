module Astryx.TypeaheadTest exposing (suite)

import Astryx.Typeahead as Typeahead
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.Typeahead"
        [ test "matches labels case-insensitively" <|
            \_ ->
                Typeahead.matches "AL" [ { value = 1, label = "Alpha", disabled = False }, { value = 2, label = "Beta", disabled = False } ]
                    |> List.map .value
                    |> Expect.equal [ 1 ]
        ]
