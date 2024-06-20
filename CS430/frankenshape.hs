import Data.List (intercalate)

data Color = Color Int Int Int

data Shape = Circle (Int, Int) Int Color | Rectangle (Int, Int) (Int, Int) Color

data Frankenshape = Frankenshape [Shape]

class SVG a where
    toSvg :: a -> String

instance SVG Color where
    toSvg svg =
        case svg of
            Color r g b -> "rgb(" ++ show r ++ ", " ++ ", " ++ show g ++ ", " ++ show b ++ ")"

instance SVG Shape where
    toSvg svg =
        case svg of
            Circle (x, y) r c -> "<circle cx=\"" ++ show x ++ "\" cy=\"" ++ show y ++ "\" r=\"" ++ show r ++ "\" fill=\"" ++ toSvg c ++ "\" />"
            Rectangle (x, y) (w, h) c -> "<rect x=\"" ++ show x ++ "\" y=\"" ++ show y ++ "\" width=\"" ++ show w ++ "\" height=\"" ++ show h ++ "\" fill=\"" ++ toSvg c ++ "\" />"

instance SVG Frankenshape where
    toSvg (Frankenshape shapes) =
        "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">" ++ "\n  " ++ (intercalate "\n  " (map toSvg shapes)) ++ "\n" ++ "</svg>\n"


main = do
    let rect1 = Rectangle (50, 30) (62, 14) $ Color 0 128 255
    let circ1 = Circle (50, 30) 99 $ Color 255 128 0
    let rect2 = Rectangle (60, 20) (61, 84) $ Color 0 18 27
    let circ2 = Circle (23, 34) 84 $ Color 25 18 0
    let rect3 = Rectangle (30, 23) (31, 34) $ Color 0 28 27
    let circ3 = Circle (33, 34) 82 $ Color 25 98 23
    let frankenshape = Frankenshape [rect1, rect2, rect3, circ1, circ2, circ3]
    let svg = toSvg frankenshape
    writeFile "shape.svg" svg
