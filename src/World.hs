module World
    ( World(..)
    , initializeWorld
    , startGame
    , updateWorld
    , worldToString
    ) where

import Player(Player(..))

data State = Setup | Playing | Paused | Finished deriving (Show, Eq)

data World = World
    { state :: State,
      player :: Player
    } deriving (Show)

initializeWorld :: Player -> World
initializeWorld newPlayer = World
    { state = Setup
    , player = newPlayer
    }

startGame :: World -> World
startGame world = world { state = Playing }

updateWorld :: World -> World
updateWorld world = world { player = updatedPlayer }
  where
    oldPlayer = player world
    updatedPlayer = oldPlayer { playerMoney = playerMoney oldPlayer + 100 }
    

worldToString :: World -> String
worldToString = show
