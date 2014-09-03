import Data.ByteString.Lazy.Char8 hiding (putStrLn)
import qualified Text.CSV.Lazy.ByteString as CSV
import System.Environment
import ShannonEntropyEstimator
import OptionParser
import CountingFilter

main = do
	argv <- getArgs
	let opts = parseOptions argv
	case opts of
		Right o -> do
			cFilter <- parseCsvToCountingFilter $ optInputFile o
			print $ estimateEntropy cFilter
		Left  err -> putStrLn $ show err

parseCsvToCountingFilter :: FilePath -> IO (CountingFilter ByteString)
parseCsvToCountingFilter = undefined
