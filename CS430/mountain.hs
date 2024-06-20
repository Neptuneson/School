import System.Directory.Internal.Prelude (getArgs)
import Control.Monad (mapM_)
import GHC.Exts (sortWith)

main = do
    file : _ <- getArgs
    text <- readFile file
    let rows = lines text
    let mRows = sortWith length rows
    mapM_ putStrLn mRows

