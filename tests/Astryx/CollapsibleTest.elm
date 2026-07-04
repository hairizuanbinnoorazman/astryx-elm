module Astryx.CollapsibleTest exposing (suite)

import Astryx.Collapsible as Collapsible
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.Collapsible"
        [ test "transitions are explicit" <|
            \_ ->
                Collapsible.init False
                    |> Collapsible.update Collapsible.Toggle
                    |> Collapsible.isOpen
                    |> Expect.equal True
        ]
