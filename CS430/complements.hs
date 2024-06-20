import System.Directory.Internal.Prelude (getArgs)
import Control.Monad (mapM_)
import Data.List (elem)

main = do
    file : _ <- getArgs
    text <- readFile file
    let nums = map read $ lines text :: [Int]
    let fnums = filter (\x -> (100 - x) `elem` nums) nums
    mapM_ print fnums

