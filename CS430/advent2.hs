import System.Environment

parseInts :: [String] -> [Int]
parseInts = map read

main = do
    file : _ <- getArgs
    text <- readFile file
    let noPlus = filter (/= '+') text
    let frequencies = parseInts $ lines noPlus
    print $ sum frequencies