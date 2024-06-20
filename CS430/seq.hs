import System.Directory.Internal.Prelude (getArgs)

main = do
    args <- getArgs
    let i = read $ head args :: Int
    let j = read $ head $ tail args :: Int
    
    if i < j then do
        let seq = [i..j]
        mapM_ print seq
    else do
        let seq = [j..i]
        mapM_ print $ reverse seq
