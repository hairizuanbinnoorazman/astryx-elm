module Astryx.CarouselTest exposing (suite)

import Astryx.Carousel as Carousel
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Astryx.Carousel"
        [ test "wraps in both directions" <|
            \_ ->
                ( Carousel.normalize 3 -1, Carousel.normalize 3 3 )
                    |> Expect.equal ( 2, 0 )
        , test "handles an empty collection" <|
            \_ ->
                Carousel.normalize 0 4 |> Expect.equal 0
        ]
