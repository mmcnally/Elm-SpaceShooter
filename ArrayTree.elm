module ArrayTree where
import Array (..)

--type ArrayTree v = Array v

-- 40 x 40 2D array (but not actually 2D)
--each section of the array will represent a 100 pixel x 100 pixel 
--portion of the screen, representing 4000 x 4000 pixels in total
basicEmpty: Array [v]
basicEmpty = repeat 1600 []

advancedEmpty: Array [Int]
advancedEmpty = initialize 1600 (\n -> [n])

treeInsert: Array [v] -> (Float, Float) -> v -> Array [v]
treeInsert tree (x, y) value =
    let getFirstQuadIndex startingValue = 
            let yIndex = abs <| (floor (y / 101)) * 20
                --yIndex' = if y == 0 then 20 else yIndex
                -- yIndex'' = if
                xIndex = abs <| truncate <| x / 101
            in (380 - yIndex) + xIndex + startingValue
        getSecondQuadIndex startingValue = 
            let yIndex = abs <| (floor  (y / 101)) * 20
                --yIndex' = if y == 0 then 20 else yIndex
                --yIndex'' = if yIndex' == 0 then 20 else yIndex'
                xIndex = abs <| truncate <| x / 101
            in (380 - yIndex) + (19 - xIndex) + startingValue
        getThirdQuadIndex startingValue = 
            let yIndex = abs <| (truncate (y / 101)) * 20
                --yIndex' = fixY yIndex
                xIndex = abs <| truncate <| x / 101
            in yIndex + (19 - xIndex) + startingValue
        getFourthQuadIndex startingValue = 
            let yIndex = abs <| (truncate (y / 101)) * 20
                --yIndex' = fixY yIndex
                xIndex = abs <| truncate <| x / 101
            in yIndex + xIndex + startingValue
                -- Quadrant I
        index = if | x >= 0 && y >= 0 -> getFirstQuadIndex 400
                -- Quadrant II
                   | x < 0 && y >= 0 -> getSecondQuadIndex 0
                -- Quadrant III
                   | x < 0 && y < 0 -> getThirdQuadIndex 800
                -- Quadrant IV
                   | x > 0 && y < 0 -> getFourthQuadIndex 1200
        thingsInIndex = getOrElse [] index tree                               
    in set index 
           (value::thingsInIndex)
           tree
                   



--main = asText <| treeInsert advancedEmpty (2000, -2000) 9999999
