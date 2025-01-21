module World
    ( World(..)
    , initializeWorld
    , startGame
    , updateWorld
    , worldToString
    ) where

import Player(Player(..))
import Data.Time

data State = Setup | Playing | Paused | Finished deriving (Show, Eq)

data World = World
    { state :: State,
      timestamp :: UTCTime,
      player :: Player
    } deriving (Show)

initializeWorld :: UTCTime -> Player -> World
initializeWorld startTimestamp newPlayer = World
    { state = Playing,
      timestamp = startTimestamp,
      player = newPlayer
    }

startGame :: World -> World
startGame world = world { state = Playing }

updateWorld :: World -> World
updateWorld world = world {
    timestamp = addUTCTime 3600 (timestamp world),
    player = updatedPlayer
  }
  where
    oldPlayer = player world
    updatedPlayer = oldPlayer { playerMoney = playerMoney oldPlayer + 100 }
    

worldToString :: World -> String
worldToString = show
