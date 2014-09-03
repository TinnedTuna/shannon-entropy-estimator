module CountingFilter (
	empty,
	insert,
	insertMany) where

import qualified Data.Map 

type CountingFilter a = Data.Map.Map a Integer

empty :: (Ord a) => CountingFilter a
empty = Data.Map.empty
 
insert :: (Ord a) => a -> CountingFilter a -> CountingFilter a
insert val cFilter =
  Data.Map.insertWith (+) val 1 cFilter

insertMany :: (Ord a) => a -> Integer -> CountingFilter a -> CountingFilter a
insertMany val count cFilter =
  Data.Map.insertWith (+) val count cFilter




