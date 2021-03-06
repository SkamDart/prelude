-- https://wiki.haskell.org/No_import_of_Prelude
{-# LANGUAGE NoImplicitPrelude #-}

-- Be explicit about types of the typeclass instance for clarity.
{-# LANGUAGE InstanceSigs      #-}

module Prelude (
  id,
  (.),
  Eq,
  Bool,
  not,
  (&&),
  (||),
  (/=),
  (==),
  ($),
  (>=>),
  otherwise,
  maybe,
  map,
  Void(..),
  unit,
  Either(..),
  either,
  fst,
  snd,
  swap,
  curry,
  uncurry,
  Functor(..),
  Applicative(..),
  Monad(..),
  Ordering(..),
) where

-- Implementation of the Haskell Predule... i.e. stdlib
-- https://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html#g:1

-- | Identity function.
id :: a -> a
id x = x

unit :: a -> ()
unit _ = ()

-- | Function composition.
(.) :: (a -> b) -> (b -> c) -> a -> c
(.) f g x = g (f x)

class Functor f where
  fmap :: (a -> b) -> f a  -> f b

class Functor f => Applicative f where
  pure :: a -> f a

class Applicative m => Monad m where
  return :: a -> m a
  (>>=) :: m a -> (a -> m b) -> m b

-- | Eq Typeclass
-- This is our notion of equality for two objects of the same type.
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool

-- | Show Typeclass
-- class Show a where
--   show :: IO ()

-- | "I ain't go no type"
data Void = Void

-- |
data Ordering = LT | EQ | GT

-- | Boolean expressed as a Sum Type.
data Bool = False
          | True

-- | A Success type (Just a) and Failure type (Nothing) encapsulated into a single sum type.
data Maybe a = Nothing
             | Just a

data Either a b = Left a
                | Right b

-- | Our boolean type must have the notion of equality.
instance Eq Bool where
  (==) True  True  = True
  (==) False False = True
  (==) _     _     = False
  (/=) x     y     = not (x == y)

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

instance (Eq a, Eq b) => Eq (Either a b) where
  (==) (Left x)  (Left y)  = x == y
  (==) (Right x) (Right y) = x == y
  (==)  _         _        = False
  (/=)  x         y        = not (x == y)

-- | Negation of a boolean.
not :: Bool -> Bool
not True  = False
not False = True

-- | Boolean `and`.
(&&) :: Bool -> Bool -> Bool
(&&) True True = True
(&&) _    _    = False

-- | Boolean `or`.
(||) :: Bool -> Bool -> Bool
(||) False False = False
(||) _     _     = True

($) :: (a -> b) -> a -> b
($) f x = f x

-- | Kleisli composition
(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
(>=>) f g x = f x >>= g

-- | Constant value of `True`.
-- Note, this is for the readability of guards.
otherwise :: Bool
otherwise = True

-- | Given a maybe value of `Nothing` a default value is returned.
-- Otherwise, a function is applied to the value inside the `Just` type.
maybe :: b -> (a -> b) -> Maybe a -> b
maybe _ f (Just x) = f x
maybe d _ Nothing  = d

map :: (a -> b) -> a -> b
map f x = f x

either :: (a -> c) -> (b -> c) -> Either a b -> c
either f _ (Left x)  = f x
either _ g (Right y) = g y

fst :: (a, b) -> a
fst (x, _) = x

snd :: (a, b) -> b
snd (_, y) = y

swap :: (a, b) -> (b, a)
swap (a, b) = (b, a)

curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x, y)

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f t = f $ fst t $ snd t
