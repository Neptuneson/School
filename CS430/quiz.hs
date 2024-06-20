divert :: String -> IO ()
divert code =
  case code of
    "R" -> print "recycle"
    "T" -> print "trash"
    _ -> error("invalid code " ++ code)