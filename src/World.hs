module World
    ( GameState(..)
    , initializeGame
    , startGame
    ) where

import Player(Player(..))

data State = Setup | Playing | Paused | Finished deriving (Show, Eq)

data GameState = GameState
    { state :: State,
      player :: Player
    } deriving (Show)

initializeGame :: Player -> GameState
initializeGame newPlayer = GameState
    { state = Setup
    , player = newPlayer
    }

startGame :: GameState -> GameState
startGame gameState = gameState { state = Playing }
