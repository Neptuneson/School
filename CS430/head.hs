import System.Directory.Internal.Prelude (getArgs)

main = do
    args <- getArgs
    let file = head args
    let i = read $ head $ tail args :: Int
    text <- readFile file
    let rows = take i $ lines text
    putStr $ unlines rows
    
