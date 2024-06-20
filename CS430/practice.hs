import System.Environment
import Data.List
import Data.Map (argSet)
import System.Posix (fileAccess)
import System.Process

pairSum :: Num a => (a, a) -> a
pairSum pair = fst pair + snd pair

majority :: Int -> Int
majority size = div size 2 + 1

neck :: [a] -> a
neck items = head $ tail items

--quadrant :: Num a => (a, a) -> String
--quadrant xy
--    | x > 0 && y > 0 = "I"
--    | x > 0 || y < 0 = "II"
--    where
--        x= fst xy
--        y = snd xy

mxb :: Float -> Float -> String
mxb m b = show m ++ " * x + " ++ show b

main1 = do
    input1 <- getLine
    input2 <- getLine
    let a = read input1 :: Int
    let b = read input2 :: Int
    print $ a * b

stringsToInts :: [String] -> [Int]
stringsToInts ss = 
    if null ss then
        []
    else
        (read (head ss) :: Int) : (stringsToInts $ tail ss)

main2 = do
    args <- getArgs
    let lhs = intercalate " + " args
    putStrLn lhs
    print $ sum $ stringsToInts args

printNumbered :: [String] -> Int -> IO ()
printNumbered rows i = do
    if null rows then
        return ()
    else do
        putStrLn $ (show i) ++ "\t" ++ (head rows)
        printNumbered (tail rows) (i + 1)

main3 = do
    args <- getArgs
    let file = head args
    text <- readFile file
    let rows = lines text
    printNumbered rows 0

say :: String -> IO()
say phrase =
    if null phrase then
        return ()
    else do
        let c = head phrase
        if c == ' ' then
            system $ "say space"
        else
            system $ "say " ++ [c]
        say $ tail phrase



main4 = do
    args <- getArgs
    let phrase = head args
    system $ "say " ++ phrase
    say phrase
    system $ "say " ++ phrase

