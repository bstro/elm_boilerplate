port module Main exposing (..)

import Navigation exposing (program)
import Html exposing (Html, div, button, text, input, br)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import Time
import String

main : Program Never
main =
    program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }


type alias Model = 
    { tick : Int
    }

model = { tick = 0 }

type Msg
    = NoOp
    | Tick Time.Time


init : Result String Int -> ( Model, Cmd Msg )
init result = urlUpdate result model


view : Model -> Html Msg
view model = Html.text <| toString model


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            model
            => Cmd.none

        Tick time ->
            let
                newModel = { model | tick = model.tick + 1 }
            in
                newModel
                => Navigation.newUrl (toUrl newModel)
  

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every Time.second Tick
        ]


toUrl : Model -> String
toUrl model = "#/" ++ (toString model.tick)


fromUrl : String -> Result String Int
fromUrl url =
    String.toInt (String.dropLeft 2 url)


urlUpdate : Result String Int -> Model -> (Model, Cmd Msg)
urlUpdate result model =
    case result of
        Ok url ->
            ({ model | tick = url }, Cmd.none)
        
        Err _ ->
            (model, Navigation.modifyUrl (toUrl model))


urlParser : Navigation.Parser (Result String Int)
urlParser = Navigation.makeParser (fromUrl << .hash)


(=>) = (,)