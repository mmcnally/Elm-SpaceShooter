module Randoms where
import Generator (..)
import Generator.Standard (..)
import Ship (..)


gen = generator 5

initialRandoms: ([Float], Generator Standard)
initialRandoms = listOf float 10 gen

function = 5
