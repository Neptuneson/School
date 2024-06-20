half :: Int -> Maybe Int
half x
  | even x = Just $ div x 2
  | otherwise = Nothing

half2 :: Int -> Either String Int
half2 x
  | even x = Right $ div x 2
  | otherwise = Left $ show x ++ " is odd"

data Medalists a = Medalists a a a

-- Only the first three in the list win a medal.
winners :: [String] -> Medalists String
winners (x : y : z : _) = Medalists x y z