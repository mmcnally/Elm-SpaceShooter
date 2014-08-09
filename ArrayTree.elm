module ArrayTree where
import Array (..)

type ArrayTree v = Array v

-- 20 x 20 2D array (but not actually 2D)
--each section of the array will represent a 100 pixel x 100 pixel 
--portion of the screen, representing 2000 x 2000 pixels in total
basicEmpty: ArrayTree v
basicEmpty = repeat 400 []


--treeInsert tree









main = asText <| basicEmpty
