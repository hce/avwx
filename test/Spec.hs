{-# LANGUAGE OverloadedStrings #-}
module Main
    ( main
    ) where

import Control.Monad
import Data.Attoparsec.Text (parseOnly)
import Data.Text

import Data.Aviation.WX

-- | Parse the given METAR text.
parseWeather :: Text -> Either String Weather
parseWeather = parseOnly weatherParser

frankfurt   :: Text
frankfurt   = "METAR EDDF 010203Z 14032KT 130V240 9999 FEW017 SCT023CB BKN042 42/23 Q1029 NOSIG="

juliana     :: Text
juliana     = "METAR TNCM 281400Z 13009KT 9999 SCT018 29/24 Q1018 A3007 NOSIG="

loxt        :: Text
loxt        = "METAR LOXT 281350Z 25007KT 220V290 50KM FEW040CU SCT120AC BKN300CI 27/12 Q1017 NOSIG RMK BKN="

main :: IO ()
main = do
    let Right frankfurt' = parseWeather frankfurt
    unless (_temperature frankfurt' == Just 42) $ error "Temperature Frankfurt should be 42 degrees"
    unless (_dewPoint frankfurt' == Just 23) $ error "Dew point Frankfurt should be 23 degrees"

    let Right juliana' = parseWeather juliana
    unless (_temperature juliana' == Just 29) $ error "It's 29 degrees in St. Maarten!"
    unless (_dewPoint juliana' == Just 24) $ error "What's with the dew point in St. Maarten?"

    let Right loxt' = parseWeather loxt
    unless (_temperature loxt' == Just 27) $ error "Temperature LOXT should be 27 degrees centigrade!"
    unless (_dewPoint loxt' == Just 12) $ error "Dew point LOXT should be 12 degrees centigrade!"
