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
  let cssClassesArrays = ((css)  =~ "[.][a-zA-Z][ A-Za-z_-]*" :: [[String]])
  let cssClasses = (map head cssClassesArrays)
  let usedClasses = (filter (html=~) cssClasses)
  let remainingClasses = [ x| x <- cssClasses, x `notElem` usedClasses]
  print remainingClasses
