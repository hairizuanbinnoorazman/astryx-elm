module FoundationTest exposing (suite)

import Astryx.Accessibility as Accessibility
import Astryx.Size as Size
import Astryx.Status as Status
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "foundation values"
        [ test "DOM identifiers are deterministic and safe" <|
            \_ -> Expect.equal "astryx-field-display-name" (Accessibility.id "Field" "Display Name")
        , test "sizes have stable class names" <|
            \_ -> Expect.equal "astryx-size-small" (Size.toClass Size.Small)
        , test "statuses have stable names" <|
            \_ -> Expect.equal "danger" (Status.toString Status.Danger)
        ]
