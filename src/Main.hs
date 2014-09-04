import Control.DeepSeq
import Data.ByteString.Lazy as BS hiding (putStrLn, foldl)
import Data.Char
import Data.Csv as CSV
import qualified Data.Vector as V
import System.Environment

import ShannonEntropyEstimator
import OptionParser
import CountingFilter as CF

main = do
	argv <- getArgs
	let opts = parseOptions argv
	case opts of
		Right o -> do
			cFilter <- parse $ optInputFile o
			case cFilter of
				Right countingFilter -> print $ estimateEntropy countingFilter
				Left error -> print error
		Left  err -> print err

parse :: FilePath -> IO (Either String (CF.CountingFilter BS.ByteString))
parse filePath = do 
	inputContents <- BS.readFile filePath
	case parseCsv inputContents of
		Right counts ->
			return $ Right $ V.foldl' (\acc (count, pass) -> CF.insertMany pass count acc) CF.empty counts 
		Left err -> return $ Left err

parseCsvOptions :: DecodeOptions
parseCsvOptions = defaultDecodeOptions 

parseCsv :: BS.ByteString -> Either String (V.Vector (Integer, BS.ByteString))
parseCsv = decodeWith parseCsvOptions NoHeader

-- | Evaluates it's argument to weak-head normal form, and returns it.
whnf a = seq a a

-- | Evaluates it's argument to full normal form, and returns it
fnf a = deepseq a a
