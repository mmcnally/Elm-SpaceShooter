module ArrayTree where
import Array (..)
import List

--type ArrayTree v = Array v

-- 40 x 40 2D array (but not actually 2D)
--each section of the array will represent a 100 pixel x 100 pixel 
--portion of the screen, representing 4000 x 4000 pixels in total
basicEmpty: Array [v]
basicEmpty = repeat 1600 []

advancedEmpty: Array [Int]
advancedEmpty = initialize 1600 (\n -> [n])

-- finds the index that hold items with
-- the given coordinates and returns it
findIndex: (Float, Float) -> Int
findIndex (x, y) = 
    let getFirstQuadIndex startingValue = 
            let yIndex = abs <| (floor (y / 100.01)) * 20
                xIndex = abs <| truncate <| x / 101
            in (380 - yIndex) + xIndex + startingValue
        getSecondQuadIndex startingValue = 
            let yIndex = abs <| (floor  (y / 100.01)) * 20
                xIndex = abs <| truncate <| x / 100.01
            in (380 - yIndex) + (19 - xIndex) + startingValue
        getThirdQuadIndex startingValue = 
            let yIndex = abs <| (truncate (y / 100.01)) * 20
                xIndex = abs <| truncate <| x / 100.01
            in yIndex + (19 - xIndex) + startingValue
        getFourthQuadIndex startingValue = 
            let yIndex = abs <| (truncate (y / 100.01)) * 20
                xIndex = abs <| truncate <| x / 100.01
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
    
-- inserts one element with given coordinates into
-- the correct section of the tree and returns the
-- modified tree
treeInsert: Array [v] -> (Float, Float) -> v -> Array [v]
treeInsert tree (x, y) value =
    let index = findIndex (x, y)
        thingsInIndex = getOrElse [] index tree                               
    in set index 
                 (value::thingsInIndex)
                 tree

-- inserts a list of values with a list of their 
--coordinates into the correct section(s) of the 
--tree and returns the modified tree
insertList: Array [v] -> [(Float, Float)] -> [v] -> Array [v]
insertList tree xys values = 
    case xys of
      [] -> tree
      otherwise -> 
          insertList (treeInsert tree (head xys) (head values))
                     (tail xys)
                     (tail values)

-- finds the section that corresponds to the coordinates
-- and returns the contents of the section as a list
getSection: Array [v] -> (Float, Float) -> [v]
getSection tree (x, y) = 
    let index = findIndex (x, y)
    in getOrElse [] index tree

-- finds the section that corresponds to the coordinates
-- and replaces the contents with the inputted list of values
editSection: Array [v] -> (Float, Float) -> [v] -> Array [v]
editSection tree (x, y) values = 
    let index = findIndex (x, y)
    in set index values tree

-- returns the contents of the tree as a list
treeToList: Array [v] -> [v]
treeToList tree = makeList tree [] 0

-- helper function for treeToList      
makeList  tree list index =
    if index > 1599
    then list
    else makeList tree
                  (list ++ (getOrElse [] index tree))
                  (index + 1)


-- checks values in tree to make sure that they're in the correct
-- section and moves them to the right section if they aren't
fixTree: (v -> (Float, Float)) -> Array [v] -> Array [v]
fixTree getCoor tree = 
    let partition = fixTreeHelper getCoor tree [] 0
        pureTree = fst partition
        rejects = snd partition
        coordinates = List.map getCoor rejects
        newTree = insertList pureTree coordinates rejects
    in newTree


fixTreeHelper: (v -> (Float, Float)) -> Array [v] -> [v] -> Int -> (Array [v], [v])
fixTreeHelper getCoor tree rejects index = 
    let pred v = 
            let valueCoor = getCoor v
                coor = indexToCoor (toFloat index)
                underTop = (snd valueCoor) < coor.yMax
                aboveBottom = (snd valueCoor) > coor.yMin
                checkLeft = (fst valueCoor) > coor.xMax
                checkRight = (fst valueCoor) < coor.xMin
            in underTop && aboveBottom && checkLeft && checkRight
        vs = (getOrElse [] index tree)
        vsPartition = partition (pred) vs
        correct = fst vsPartition
        incorrect = snd vsPartition
        tree' = set index correct tree
    in if index < 1600
       then fixTreeHelper getCoor
                          tree'
                          (rejects ++ incorrect)
                          (index + 1)
       else (tree, rejects)
            
                




-- take in an index and returns the bounding coordinates of the section:
-- minimum y value, maximum y value, minimum x value, maximum x value
indexToCoor: Float -> { yMin: Float, yMax: Float, xMin: Float, xMax: Float }    
indexToCoor index = 
    -- Quadrant II
    if | index < 400 ->
           let yMax = toFloat <| 2000 - ((truncate (index / 20)) * 100)
               yMin = yMax - 100
               correctLine = (truncate index) `mod` 20
               xMin = toFloat <| -2000 + (correctLine * 100)
               xMax = xMin + 100
           in { yMin = yMin, yMax = yMax, xMin = xMin, xMax = xMax }
    -- Quadrant I
        | index < 800 ->
           let index' = index - 400
               yMax = toFloat <| 2000 - ((truncate (index' / 20)) * 100)
               yMin = yMax - 100
               correctLine = (truncate index') `mod` 20
               xMin = toFloat <| correctLine * 100
               xMax = xMin + 100
           in { yMin = yMin, yMax = yMax, xMin = xMin, xMax = xMax }
    -- Quadrant III
        | index < 1200 ->
           let index' = index - 800
               yMax = toFloat <| -1 * ((truncate (index' / 20)) * 100)
               yMin = yMax - 100
               correctLine = (truncate index') `mod` 20
               xMin = toFloat <| -2000 + (correctLine * 100)
               xMax = xMin + 100
           in { yMin = yMin, yMax = yMax, xMin = xMin, xMax = xMax }
    -- Quadrant IV
        | index < 1600 ->
           let index' = index - 1200
               yMax = toFloat <| -1 * ((truncate (index' / 20)) * 100)
               yMin = yMax - 100
               correctLine = (truncate index') `mod` 20
               xMin = toFloat <| correctLine * 100
               xMax = xMin + 100
           in { yMin = yMin, yMax = yMax, xMin = xMin, xMax = xMax }
        | otherwise -> { yMin = 0, yMax = 0, xMin = 0, xMax = 0}
           
           
treeMap: (v -> v) -> Array [v] -> Array [v]
treeMap function tree = treeMapHelper function tree 0
    

treeMapHelper: (v -> v) -> Array [v] -> Int -> Array [v]
treeMapHelper function tree index = 
    if | index < 1600 ->
           let vs = getOrElse [] index tree
               vs' = List.map (function) vs
               newTree = set index vs' tree
           in treeMapHelper function newTree (index + 1)
       | otherwise -> tree



--
-- TEST CODE BELOW
--

tree =  treeInsert basicEmpty (0, 2000) (0, 2000)
--tree' = getSection tree (1990, -1990)
--tree' = editSection tree (-1, 2) [1, 2, 3, 4]
--tree'' = treeToList tree'
--tree' = editSection tree (0, 2000) [(0, 500)]
getCoor v = (fst v, snd v)

tree' = treeMap function tree

function v = 
    let newEnd = (snd v) / 2
    in (fst v, newEnd)

main = asText <| fixTree getCoor tree'

