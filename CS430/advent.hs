import System.Environment

main = do
    directions : _ <- getArgs
    let offsets = map (\p -> if p == '(' then 1 else -1) directions
    let floor = sum offsets
    print floor
    