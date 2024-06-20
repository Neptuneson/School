import System.Directory.Internal.Prelude (getArgs)
import Control.Monad (mapM_)
import Data.List (sort)

main = do
  file : _ <- getArgs
  text <- readFile file
  let nums = map read $ lines text :: [Int]
  let snums = sort nums
  mapM_ print snums