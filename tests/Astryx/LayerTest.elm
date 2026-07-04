module Astryx.LayerTest exposing (suite)

import Astryx.Layer as Layer
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.Layer"
        [ test "layers have stable ordering and nested close semantics" <|
            \_ ->
                Layer.init
                    |> Layer.open Layer.Modal "dialog"
                    |> Layer.open Layer.NonModal "menu"
                    |> Layer.close "dialog"
                    |> Layer.layers
                    |> Expect.equal []
        , test "only the top layer accepts dismissal" <|
            \_ ->
                let
                    state =
                        Layer.init
                            |> Layer.open Layer.Modal "dialog"
                            |> Layer.open Layer.NonModal "menu"
                in
                Layer.dismiss Layer.Escape "dialog" state
                    |> Layer.layers
                    |> Expect.equal [ "dialog", "menu" ]
        ]
