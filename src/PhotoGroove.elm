module PhotoGroove exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type alias Photo =
    { url : String }


type alias Model =
    { photos : List Photo
    , selectedUrl : String
    }


type alias Msg =
    { description : String
    , data : String
    }


urlPrefix =
    "http://elm-in-action.com/"


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
        , img
            [ class "large"
            , src (urlPrefix ++ "large/" ++ model.selectedUrl)
            ]
            []
        ]


viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedUrl thumbnail =
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selected", selectedUrl == thumbnail.url ) ]
        , onClick { description = "ClickedPhoto", data = thumbnail.url }
        ]
        []


update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data }

    else
        model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
