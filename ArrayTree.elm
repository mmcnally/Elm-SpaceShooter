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

findIndex: (Float, Float) -> Int
findIndex (x, y) = 
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
    in index
    

treeInsert: Array [v] -> (Float, Float) -> v -> Array [v]
treeInsert tree (x, y) value =
    let index = findIndex (x, y)
        thingsInIndex = getOrElse [] index tree                               
    in set index 
           (value::thingsInIndex)
           tree

insertList: Array [v] -> [(Float, Float)] -> [v] -> Array [v]
insertList tree xys values = 
    case xys of
      [] -> tree
      otherwise -> 
          insertList (treeInsert tree (head xys) (head values))
                     (tail xys)
                     (tail values)

getSection: Array [v] -> (Float, Float) -> [v]
getSection tree (x, y) = 
    let index = findIndex (x, y)
    in getOrElse [] index tree

editSection: Array [v] -> (Float, Float) -> [v] -> Array [v]
editSection tree (x, y) values = 
    let index = findIndex (x, y)
    in set index values tree

treeToList: Array [v] -> [v]
treeToList tree = makeList tree [] 0

-- helper function for treeToList      
makeList  tree list index =
    if index > 1599
    then list
    else makeList tree
                  (list ++ (getOrElse [] index tree))
                  (index + 1)




--
-- TEST CODE BELOW
--

tree =  treeInsert basicEmpty (2000, -2000) 9999999
--tree' = getSection tree (1990, -1990)
tree' = editSection tree (-2000, 2000) [1, 2, 3, 4]
tree'' = treeToList tree'


main = asText <| tree''

