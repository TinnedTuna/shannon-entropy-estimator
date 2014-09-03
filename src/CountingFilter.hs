module CountingFilter (
	empty,
	insert,
	insertMany,
	CountingFilter) where

import qualified Data.Map 

type CountingFilter a = Data.Map.Map a Integer

-- | Produce an empty counting filter.
empty :: (Ord a) => CountingFilter a
empty = Data.Map.empty
 
-- | Increment the value in the given filter once.
insert :: (Ord a) => a -> CountingFilter a -> CountingFilter a
insert val cFilter =
  Data.Map.insertWith (+) val 1 cFilter

-- | Increment the value in the given filter the given number of times.
insertMany :: (Ord a) => a -> Integer -> CountingFilter a -> CountingFilter a
insertMany val count cFilter =
  Data.Map.insertWith (+) val count cFilter




