module Astryx.SizeTest exposing (suite)

import Astryx.Size as Size
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.Size"
        [ test "sizes have stable class names" <|
            \_ -> Expect.equal "astryx-size-small" (Size.toClass Size.Small)
        ]
