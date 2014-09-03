module ShannonEntropyEstimator (
	estimateEntropy) where

import CountingFilter
import qualified Data.Map

-- | Estimate the entropy of a given dataset according to Shannon's measure.
estimateEntropy :: (Ord a) => CountingFilter a -> Float
estimateEntropy cFilter = 
	-(sum $ map (\p -> p * log p) $ Data.Map.elems $ normaliseFilter cFilter)
	
-- | Convert a counting filter into a map of value and probability
normaliseFilter :: (Ord a) => CountingFilter a -> Data.Map.Map a Float
normaliseFilter cFilter = 
	Data.Map.map (\val -> (fromIntegral val) / (fromIntegral total)) cFilter
	where
	total = countAllElements cFilter

-- | Find the total number of elements in a counting filter
countAllElements :: (Ord a) => CountingFilter a -> Integer
countAllElements = sum . Data.Map.elems

