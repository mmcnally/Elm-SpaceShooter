module QuadTree where


type BoundingBox = { left : Float,
                     right : Float,
                     top : Float,
                     bottom : Float }
type XY a = { a | x: Float, y: Float }

data QuadTree v = Leaf BoundingBox [v] 
                -- Bounding Box encompasses all 4 QuadTrees
                -- In order: top left, top right, bottom left, bottom right
                | Branch BoundingBox (QuadTree v) (QuadTree v) (QuadTree v) (QuadTree v)

-- creates empty QuadTree based based on 
-- inputted bounding box and section size
empty : BoundingBox -> (Float, Float) -> QuadTree v
empty {left, right, top, bottom} (width, height) =
    let h = (top - bottom)
        w = (right - left)
    in if | w <= width && h <= height -> Leaf (BoundingBox left right top bottom) []
          | otherwise -> Branch (BoundingBox left right top bottom) 
                         -- Top Left
                         (empty (BoundingBox left (left + w/2) top (top - h/2)) (width, height))
                         -- Top Right
                         (empty (BoundingBox (right - w/2) right top (bottom + h/2)) (width, height))
                         -- Bottom Left
                         (empty (BoundingBox left (left + w/2) (bottom + h/2) bottom) (width, height))
                         -- Bottom Right
                         (empty (BoundingBox (right - w/2) right (bottom + h/2) bottom) (width, height))

-- creates empty QuadTree with bounding box of 2000 px in each direction
basicEmpty: QuadTree v
basicEmpty = empty { left = -2000, right = 2000, top = 2000, bottom = -2000 } 
                   (500, 500)


-- inserts a value of some sort with an (x, y) location
-- into the correct part of the tree, and returns the modified tree
treeInsert : QuadTree v -> (Float, Float) -> v -> QuadTree v
treeInsert qtree (x, y) value = 
    case qtree of
      Leaf box vs -> Leaf box (value::vs)
      Branch {left, right, top, bottom} tl tr bl br ->
          let height = (top - bottom)/2
              width = (right - left)/2
          in if | y > (top - height) && x < (left + width) -> 
                    Branch {left = left, right = right, 
                            top = top, bottom = bottom}
                           (treeInsert tl (x, y) value)
                           tr
                           bl
                           br
                | y > (top - height) && x >= (left + width) -> 
                    Branch {left = left, right = right,
                            top = top, bottom = bottom}
                           tl
                           (treeInsert tr (x, y) value)
                           bl
                           br
                           
                | y <= (top - height) && x < (left + width) -> 
                    Branch {left = left, right = right,
                            top = top, bottom = bottom}
                           tl
                           tr
                           (treeInsert bl (x, y) value)
                           br
                | y <= (top - height) && x >= (left + width) -> 
                    Branch {left = left, right = right,
                            top = top, bottom = bottom}
                           tl
                           tr
                           bl
                           (treeInsert br (x, y) value)
                | otherwise -> qtree

insertList: QuadTree v -> [(Float, Float)] -> [v] -> QuadTree v
insertList qtree xys values = 
    case xys of
      [] -> qtree
      otherwise -> 
          insertList (treeInsert qtree (head xys) (head values))
                     (tail xys)
                     (tail values)
    

getLeaf : QuadTree v -> (Float, Float) -> [v]
getLeaf qtree (x, y) = 
    case qtree of
      Leaf _ vs -> vs
      Branch {left, right, top, bottom} tl tr bl br ->
          let height = (top - bottom)/2
              width = (right - left)/2
          in if | y > (top - height) && x < (left + width) -> getLeaf tl (x, y)
                | y > (top - height) && x >= (left + width) -> getLeaf tr (x, y)
                | y <= (top - height) && x < (left + width) -> getLeaf bl (x, y)
                | y <= (top - height) && x >= (left + width) -> getLeaf br (x, y)
                | otherwise -> []

editLeaf: QuadTree v -> (Float, Float) -> [v] -> QuadTree v
editLeaf qtree (x, y) vs' = 
    case qtree of 
      Leaf bb vs -> Leaf bb vs'
      Branch {left, right, top, bottom} tl tr bl br ->
          let height = (top - bottom) / 2
              width = (right - left) / 2
          in if | y > (top - height) && x < (left + width) -> 
                    Branch {left = left, right = right,
                            top = top, bottom = bottom}
                           (editLeaf tl (x, y) vs')
                           tr
                           bl
                           br
                | y > (top - height) && x >= (left + width) -> 
                    Branch {left = left, right = right,
                            top = top, bottom = bottom}
                           tl
                           (editLeaf tr (x, y) vs')
                           bl
                           br
                | y <= (top - height) && x < (left + width) -> 
                    Branch {left = left, right = right,
                            top = top, bottom = bottom}
                           tl
                           tr
                           (editLeaf bl (x, y) vs')
                           br
                | y <= (top - height) && x >= (left + width) -> 
                    Branch {left = left, right = right,
                            top = top, bottom = bottom}
                           tl
                           tr
                           bl
                           (editLeaf br (x, y) vs')
                | otherwise -> qtree

treeToList: QuadTree v -> [v] -> [v]
treeToList qtree list = 
    case qtree of
      Leaf _ vs -> vs ++ list
      Branch _ tl tr bl br ->
          let topLeft = treeToList tl []
              topRight = treeToList tr []
              bottomLeft = treeToList bl []
              bottomRight = treeToList br []
          in topLeft ++ topRight ++ bottomLeft ++ bottomRight ++ list



fixTree: (v -> (Float, Float)) -> QuadTree v -> QuadTree v
fixTree getCoor qtree = 
    let partition = fixTreeHelper qtree [] getCoor
        pureTree = fst partition
        rejects = snd partition
        coordinates = map getCoor rejects
        reInserted = insertList pureTree coordinates rejects
    in reInserted
                

fixTreeHelper: QuadTree v -> [v] -> (v -> (Float, Float)) -> (QuadTree v, [v])
fixTreeHelper qtree rejects getCoor = 
    case qtree of
      Leaf bb vs -> 
          let pred bb v = 
                  let coor = getCoor v
                      underTop = (fst coor) < bb.top
                      aboveBottom = (fst coor) > bb.bottom
                      checkLeft = (snd coor) > bb.left
                      checkRight = (snd coor) < bb.right
                  in underTop && aboveBottom && checkLeft && checkRight
              vsPartition = partition (pred bb) vs
              correct = fst vsPartition
              incorrect = snd vsPartition
          in ((Leaf bb correct), rejects ++ incorrect)
      Branch bb tl tr bl br ->
          let topLeft = fixTreeHelper tl rejects getCoor
              ctl = fst topLeft
              itl = snd topLeft
              topRight = fixTreeHelper tr rejects getCoor
              ctr = fst topRight
              itr = snd topRight
              bottomLeft = fixTreeHelper bl rejects getCoor
              cbl = fst bottomLeft
              ibl = snd bottomLeft
              bottomRight = fixTreeHelper br rejects getCoor
              cbr = fst bottomRight
              ibr = snd bottomRight
          in ((Branch bb ctl ctr cbl cbr), rejects ++ itl ++ itr ++ ibl ++ ibr)



treeMap: (v -> m) -> QuadTree v -> QuadTree m
treeMap function qtree = 
    case qtree of
      Leaf bb vs -> 
          let vs' = map (function) vs
          in Leaf bb vs'
      Branch bb tl tr bl br ->
          let topLeft = treeMap function tl
              topRight = treeMap function tr
              bottomLeft = treeMap function bl
              bottomRight = treeMap function br
          in Branch bb topLeft topRight bottomLeft bottomRight

--filterPred: m -> Bool
--filterPred m = (abs m.x) < 2000 && (abs m.y) < 2000

treeFilter: (v -> Bool) -> QuadTree v -> QuadTree v
treeFilter predicate qtree =
    case qtree of
         Leaf bb vs ->
             let vs' = filter predicate vs
             in Leaf bb vs'
         Branch bb tl tr bl br -> 
             let topLeft = treeFilter predicate tl
                 topRight = treeFilter predicate tr
                 bottomLeft = treeFilter predicate bl
                 bottomRight = treeFilter predicate br
             in Branch bb topLeft topRight bottomLeft bottomRight

treePartition: (v -> Bool) -> QuadTree v -> QuadTree v -> (QuadTree v, QuadTree v)
treePartition predicate qtree newTree = 
    case qtree of
      Leaf bb vs -> 
          let vsPartition = partition (predicate) vs
              correct = fst vsPartition
              incorrect = snd vsPartition
          in ((Leaf bb correct), (Leaf bb incorrect))
      Branch bb tl tr bl br ->
          let topLeft = treePartition predicate tl newTree
              ctl = fst topLeft
              itl = snd topLeft
              topRight = treePartition predicate tr newTree
              ctr = fst topRight
              itr = snd topRight
              bottomLeft = treePartition predicate bl newTree
              cbl = fst bottomLeft
              ibl = snd bottomLeft
              bottomRight = treePartition predicate br newTree
              cbr = fst bottomRight
              ibr = snd bottomRight
          in ((Branch bb ctl ctr cbl cbr), (Branch bb itl itr ibl ibr))
      
    

--
-- TEST FUNCTIONS
--

--stupidTree = empty { left = -500, right =  500, top = 500, bottom = -500 } (100, 100)

base = treeInsert basicEmpty (0, 400) 1
tree' = treeInsert base (400, 300) 2
tree'' = treeInsert tree' (-1900, -1900) 3
tree''' = treeInsert tree'' (-233, 433) 4
tree'''' = insertList tree''' [(100, 100), (232, 4), (23, 234)] [200, 500, 401]
tree''''' = editLeaf tree'''' (400, 300) [12]
tree'''''' = getLeaf tree'' (-1900, -1900)

--fake predicate for test function
pred v = if v > 100 
       then True
       else False

--main = asText <| tree'''''
{-
main = flow down [ asText (treeToList tree' []),
                   asText (treeToList tree'' []),
                   asText (treeToList tree''' []), 
                   asText (treeToList tree'''' []), 
                   asText (treeToList tree''''' []),
                   asText tree'''''',
                   asText tree']
-}

--main = asText <| tree''''

--main = asText <| treePartition  pred tree'''' basicEmpty
treeToString: QuadTree v -> [Element] -> [Element]
treeToString qtree elements= 
    case qtree of
      Leaf bb vs -> 
          let newElems = [plainText "Leaf: ", 
                          plainText "BoundingBox: ", asText bb,
                          plainText "vs: ", asText vs,
                          plainText "\n" ]
          in elements ++ newElems
      Branch bb tl tr bl br ->
          let newElems = [plainText "Branch: ",
                          plainText "BoundingBox: ", asText bb]
                         
              elems = elements ++ newElems
              topLeft = treeToString tl (elems ++ [plainText "tl\n"])
              topRight = treeToString tr (topLeft ++ [plainText "tr\n"])
              bottomRight = treeToString br (topRight ++ [plainText "br\n"])
              bottomLeft = treeToString bl (bottomRight ++ [plainText "bl\n"])
          in bottomLeft