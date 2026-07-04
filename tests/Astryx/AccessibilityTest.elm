module Astryx.AccessibilityTest exposing (suite)

import Astryx.Accessibility as Accessibility
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.Accessibility"
        [ test "DOM identifiers are deterministic and safe" <|
            \_ -> Expect.equal "astryx-field-display-name" (Accessibility.id "Field" "Display Name")
        ]
