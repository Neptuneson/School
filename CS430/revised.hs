import GHC.Exts (sortWith)

runts :: [(a, a)] -> [a]
runts list = do
  let sort = sortWith length list
  
  []
