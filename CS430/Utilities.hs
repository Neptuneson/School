module Utilities where

parseInts :: [String] -> [Int]
parseInts = map read

count :: (a -> Bool) -> [a] -> Int
count predicate = length . filter predicate