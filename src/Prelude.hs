-- https://wiki.haskell.org/No_import_of_Prelude
{-# LANGUAGE NoImplicitPrelude #-}

-- Explicit about types of the typeclass instance for clarity.
{-# LANGUAGE InstanceSigs #-}

module Prelude () where

-- Implementation of the Haskell Predule... i.e. stdlib
-- https://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html#g:1

-- | Eq Typeclass
-- This is our notion of equality for two objects of the same type.
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool

-- | Show Typeclass
-- class Show a where
--   show :: IO ()

-- | Boolean expressed as a Sum Type.
data Bool = False
          | True

-- | Our boolean type must have the notion of equality.
instance Eq Bool where
  (==) True  True  = True
  (==) False False = True
  (==) _     _     = False
  (/=) x     y     = not (x == y)

-- | Negation of a boolean.
not :: Bool -> Bool
not True = False
not False = True

-- | Boolean `and`.
(&&) :: Bool -> Bool -> Bool
(&&) True True = True
(&&) _    _    = False

-- | Boolean `or`.
(||) :: Bool -> Bool -> Bool
(||) False False = False
(||) _     _     = True

-- | Constant value of `True`.
-- Note, this is for the readability of guards.
otherwise :: Bool
otherwise = True

-- | A Success type (Just a) and Failure type (Nothing) encapsulated into a single sum type.
data Maybe a = Nothing
             | Just a

-- | Instance of Eq for our boolean with the somewhat obvious Eq constraint on a.
instance Eq a => Eq (Maybe a) where
  -- | (Maybe a) equality
  (==) :: Maybe a -> Maybe a -> Bool
  (==) (Just x) (Just y) = x == y
  (==) Nothing  Nothing  = True
  (==) _        _        = False
  -- | (Maybe a) not equal.
  (/=) :: Maybe a -> Maybe a -> Bool
  (/=) x        y        = not (x == y)

-- | Given a maybe value of `Nothing` a default value is returned.
-- Otherwise, a function is applied to the value inside the `Just` type.
maybe :: b -> (a -> b) -> Maybe a -> b
maybe _ f (Just x) = f x
maybe d _ Nothing  = d

