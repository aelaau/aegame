module Player
( Player(..)
  ) where

import Types

data Player = Player
    { playerName :: String
    , playerMoney :: Money
    } deriving (Show, Eq)
