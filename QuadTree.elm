module QuadTree where


type BoundingBox = { left : Float,
                     right : Float,
                     top : Float,
                     bottom : Float }

data QuadTree v = Leaf BoundingBox [v] 
                -- Bounding Box encompasses all 4 QuadTrees
                -- In order: top left, top right, bottom left, bottom right
                | Branch BoundingBox (QuadTree v) (QuadTree v) (QuadTree v) (QuadTree v)

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

insert : QuadTree v -> v -> (Float, Float) -> QuadTree v
insert qtree value (x, y) = 
    case qtree of
      Leaf box vs -> Leaf box (value::vs)
      Branch {left, right, top, bottom} tl tr bl br ->
          let height = (top - bottom)/2
              width = (right - left)/2
          in if | y > (top - height) && x < (left + width) -> insert tl value (x, y)
                | y > (top - height) && x >= (left + width) -> insert tr value (x, y)
                | y <= (top - height) && x < (left + width) -> insert bl value (x, y)
                | y <= (top - height) && x >= (left + width) -> insert br value (x, y)
                | otherwise -> qtree

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

toList: QuadTree v -> [v] -> [v]
toList qtree list = 
    case qtree of
      Leaf _ vs -> vs ++ list
      Branch _ tl tr bl br ->
          let topLeft = toList tl []
              topRight = toList tr []
              bottomLeft = toList bl []
              bottomRight = toList br []
          in topLeft ++ topRight ++ bottomLeft ++ bottomRight ++ list

--main = asText toList 


stupidTree = empty { left = -500, right =  500, top = 500, bottom = -500 } (100, 100)


tree = insert stupidTree 1 (0, 100)
tree' = insert tree 2 (400, 300)
tree'' = insert tree' 3 (32, 43)
tree''' = insert tree'' 4 (-233, 433)

main = asText <| toList tree''' []