module Astryx.Lightbox exposing (Config, Item, view)

{-| Modal media viewer. @docs Config, Item, view
-}

import Astryx.Carousel as Carousel
import Astryx.Dialog as Dialog
import Astryx.Layer as Layer
import Html exposing (Attribute, Html)


{-| One labelled media item.
-}
type alias Item msg =
    Carousel.Slide msg


{-| Controlled lightbox configuration.
-}
type alias Config msg =
    { id : Layer.Id, layers : Layer.State, label : String, items : List (Item msg), current : Int, onChange : Int -> msg, onDismiss : Layer.Dismissal -> msg, attributes : List (Attribute msg) }


{-| Render media inside a modal dialog.
-}
view : Config msg -> Html msg
view config =
    Dialog.view { id = config.id, layers = config.layers, title = config.label, body = [ Carousel.view { label = config.label, slides = config.items, current = config.current, previousLabel = "Previous item", nextLabel = "Next item", onChange = config.onChange, attributes = [] } ], footer = [], onDismiss = config.onDismiss, attributes = config.attributes }
