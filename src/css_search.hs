-- Searches through CSS files and builds a hash of classes and ID's
--
--

import System.Environment
import System.IO
import Control.Monad
import Text.Regex.Posix
import Data.Foldable


main :: IO ()
main = do
  css <- readFile "testData/a.css"
  html <- readFile "testData/test.html"
  let cssClasses = extractCSS css
  let remainingClasses = filterCSS cssClasses html
  print remainingClasses

extractCSS :: String -> [String]
extractCSS css = (map head ((css)  =~ "[.][a-zA-Z][ A-Za-z_-]*" :: [[String]]))

filterCSS :: ([String], String) -> [String]
filterCSS [ x| x <- cssClasses, x `notElem` (filter (html=~) cssClasses)]

