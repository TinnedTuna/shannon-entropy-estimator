module OptionParser ( 
  Options,
  optInputFile,
  parseOptions) where

import System.Console.GetOpt

data Options = Options { optInputFile :: FilePath }
defaultOptions = Options { optInputFile = "passwords-list.csv" }

-- http://hackage.haskell.org/package/base-4.6.0.0/docs/System-Console-GetOpt.html#g:4
options :: [OptDescr (Options -> Options)]
options = [Option ['i'] ["inputFile"] (ReqArg (\f opts -> opts { optInputFile = f }) "FILE") "input FILE"]

parseOptions :: [String] -> Either String Options
parseOptions argv = 
  case getOpt Permute options argv of
    (o,n,[]) -> Right $ foldl (flip id) defaultOptions o 
    (_,_,errs) -> Left $ concat errs ++ usageInfo headers options
  where
    headers = "Usage: shannon-entropy-estimation --inputFile=FILE" 
