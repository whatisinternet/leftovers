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
  css <- loadFiles ["testData/a.css", "testData/b.css"]
  html <- readFile "testData/test.html"
  let cssClasses = extractCSS css
  let remainingClasses = filterCSS (cssClasses, html)
  print remainingClasses

loadFiles :: [String] -> IO String
loadFiles fileNames = do
    output <- head (map readFile fileNames)
    return output

extractCSS :: String -> [String]
extractCSS css = (map head ((css)  =~ "[.][a-zA-Z][ A-Za-z_-]*" :: [[String]]))

filterCSS :: ([String], String) -> [String]
filterCSS (cssClasses, html) = [ x| x <- cssClasses, x `notElem` (filter (html=~) cssClasses)]

