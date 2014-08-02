module QuadTree where


type BoundingBox = { left : Float,
                     right : Float,
                     top : Float,
                     bottom : Float }

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
                   (100, 100)


treeInsert : QuadTree v -> (Float, Float) -> v -> QuadTree v
treeInsert qtree (x, y) value = 
    case qtree of
      Leaf box vs -> Leaf box (value::vs)
      Branch {left, right, top, bottom} tl tr bl br ->
          let height = (top - bottom)/2
              width = (right - left)/2
          in if | y > (top - height) && x < (left + width) -> treeInsert tl (x, y) value
                | y > (top - height) && x >= (left + width) -> treeInsert tr (x, y) value
                | y <= (top - height) && x < (left + width) -> treeInsert bl (x, y) value
                | y <= (top - height) && x >= (left + width) -> treeInsert br (x, y) value
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

--treeFilter: (QuadTree v -> Bool) -> QuadTree v -> QuadTree v
--treeFilter predicate qtree = 
    


stupidTree = empty { left = -500, right =  500, top = 500, bottom = -500 } (100, 100)

tree = treeInsert stupidTree (0, 100) 1
tree' = treeInsert tree (400, 300) 2
tree'' = treeInsert tree' (32, 43) 3
tree''' = treeInsert tree'' (-233, 433) 4

--main = asText <| treeToList tree''' []