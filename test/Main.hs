module Main where

import System.Exit (exitFailure)

main :: IO ()
main = do
  putStrLn "This always fails"
  exitFailure
