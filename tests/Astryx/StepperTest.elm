module Astryx.StepperTest exposing (suite)

import Astryx.Stepper as Stepper
import Html.Attributes as Attr
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, containing, tag)


suite : Test
suite =
    describe "Astryx.Stepper"
        [ test "renders an ordered sequence and identifies the current step" <|
            \_ ->
                Stepper.view "Account setup"
                    []
                    [ { label = "Profile", description = Nothing, state = Stepper.Complete }
                    , { label = "Security", description = Just "Add a passkey", state = Stepper.Current }
                    , { label = "Finish", description = Nothing, state = Stepper.Pending }
                    ]
                    |> Query.fromHtml
                    |> Query.has
                        [ tag "ol"
                        , attribute (Attr.attribute "aria-label" "Account setup")
                        , containing [ tag "li", attribute (Attr.attribute "aria-current" "step") ]
                        ]
        ]
