module Astryx.Button exposing (Option, button, submit, reset, primary, secondary, ghost, destructive, small, medium, large, disabled, loading, onClick, view)

{-| Accessible native buttons.

@docs Option, button, submit, reset, primary, secondary, ghost, destructive, small, medium, large, disabled, loading, onClick, view

-}

import Astryx.Internal.Attributes as Attributes
import Astryx.Size as Size
import Html exposing (Attribute, Html, span)
import Html.Attributes as Attr
import Html.Events as Events


{-| An opaque button configuration option.
-}
type Option msg
    = Class String
    | Disabled Bool
    | Loading Bool
    | Kind String
    | Click msg


{-| Use the primary appearance.
-}
primary : Option msg
primary =
    Class "astryx-button--primary"


{-| Use the secondary appearance.
-}
secondary : Option msg
secondary =
    Class "astryx-button--secondary"


{-| Use the low-emphasis ghost appearance.
-}
ghost : Option msg
ghost =
    Class "astryx-button--ghost"


{-| Use the destructive appearance.
-}
destructive : Option msg
destructive =
    Class "astryx-button--destructive"


{-| Use the small size.
-}
small : Option msg
small =
    Class (Size.toClass Size.Small)


{-| Use the medium size.
-}
medium : Option msg
medium =
    Class (Size.toClass Size.Medium)


{-| Use the large size.
-}
large : Option msg
large =
    Class (Size.toClass Size.Large)


{-| Disable the button.
-}
disabled : Bool -> Option msg
disabled =
    Disabled


{-| Mark the button busy and disable activation.
-}
loading : Bool -> Option msg
loading =
    Loading


{-| Emit a message when activated.
-}
onClick : msg -> Option msg
onClick =
    Click


{-| Use `type="button"`.
-}
button : Option msg
button =
    Kind "button"


{-| Use `type="submit"`.
-}
submit : Option msg
submit =
    Kind "submit"


{-| Use `type="reset"`.
-}
reset : Option msg
reset =
    Kind "reset"


{-| Render a native button.
-}
view : List (Option msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
view options attributes children =
    let
        busy =
            List.any isLoading options

        inactive =
            busy || List.any isDisabled options

        spinner =
            if busy then
                [ span [ Attr.class "astryx-spinner", Attr.attribute "aria-hidden" "true" ] [] ]

            else
                []
    in
    Html.button
        (Attributes.merge
            ([ Attr.class "astryx-button", Attr.disabled inactive ]
                ++ List.concatMap (optionAttributes inactive) options
                ++ (if busy then
                        [ Attr.attribute "aria-busy" "true" ]

                    else
                        []
                   )
            )
            attributes
        )
        (spinner ++ children)


isLoading : Option msg -> Bool
isLoading option =
    case option of
        Loading True ->
            True

        _ ->
            False


isDisabled : Option msg -> Bool
isDisabled option =
    case option of
        Disabled True ->
            True

        _ ->
            False


optionAttributes : Bool -> Option msg -> List (Attribute msg)
optionAttributes inactive option =
    case option of
        Class name ->
            [ Attr.class name ]

        Disabled _ ->
            []

        Loading _ ->
            []

        Kind value ->
            [ Attr.type_ value ]

        Click message ->
            if inactive then
                []

            else
                [ Events.onClick message ]
