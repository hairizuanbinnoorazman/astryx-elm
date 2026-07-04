module Astryx.StatusTest exposing (suite)

import Astryx.Status as Status
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.Status"
        [ test "statuses have stable names" <|
            \_ -> Expect.equal "danger" (Status.toString Status.Danger)
        ]
