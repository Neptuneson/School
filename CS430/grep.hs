import System.Directory.Internal.Prelude (getArgs)
import Control.Monad (forM_)
import Data.List (isInfixOf)

grepFile :: String -> FilePath -> IO ()
grepFile find file = do
    text <- readFile file
    let rows = lines text
    let lp = filter (isInfixOf find) rows
    mapM_ putStrLn lp

main = do
    find : files <- getArgs
    forM_ files (grepFile find)

