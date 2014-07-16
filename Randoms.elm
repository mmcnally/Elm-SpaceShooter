module Randoms where
import Generator (..)
import Generator.Standard (..)
import Ship (..)


-- generator for initialRandoms
gen = generator 5

-- creates 10 initial random numbers
initialRandoms: ([Float], Generator Standard)
initialRandoms = listOf (floatRange (0, 1000)) 10 gen

-- updates Randoms with 10 new random
-- numbers based off old generator
update: ([Float], Generator Standard) -> ([Float], Generator Standard)
update old = listOf (floatRange (0, 1000)) 10 (snd old)