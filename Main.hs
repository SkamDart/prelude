-- https://wiki.haskell.org/No_import_of_Prelude
{-# LANGUAGE NoImplicitPrelude #-}

module Main where

import Test.QuickCheck

main = quickCheck (const True)
