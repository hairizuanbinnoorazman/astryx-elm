module Astryx.ToastTest exposing (suite)

import Astryx.Toast as Toast
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text)


type Msg
    = ToastMsg Toast.Msg


suite : Test
suite =
    describe "Astryx.Toast"
        [ test "dismiss removes the notification" <|
            \_ ->
                Toast.init
                    |> Toast.add { id = "saved", title = "Saved", message = "Done" }
                    |> Toast.dismiss "saved"
                    |> Toast.view ToastMsg []
                    |> Query.fromHtml
                    |> Query.hasNot [ text "Saved" ]
        ]
