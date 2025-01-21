module Main(main) where

import Network.Socket
import Network.Socket.ByteString (sendAll)
import qualified Data.ByteString.Char8 as BS
import Control.Exception (bracket)
import Control.Monad (forever)
import Control.Monad.State
import Data.Time

import World
import Player

type WorldM = StateT World IO

main :: IO ()
main = do
  let startTimestamp = UTCTime (fromGregorian 2025 1 1) 0
  let newPlayer = Player "Player 1" 100
  let initialWorld = initializeWorld startTimestamp newPlayer
  let socketPath = "/tmp/aesock"
  runSocketGame socketPath initialWorld

runSocketGame :: FilePath -> World -> IO ()
runSocketGame socketPath initialWorld = do
    bracket (aeOpenSocket socketPath) close $ \sock -> do
        putStrLn $ "Socket opened: " ++ socketPath
        evalStateT (socketLoop sock) initialWorld

socketLoop :: Socket -> WorldM ()
socketLoop sock = forever $ do
    (conn, _) <- liftIO $ accept sock
    liftIO $ putStrLn "Client connected."

    tick
    updatedWorld <- get
    let gameStateStr = worldToString updatedWorld

    liftIO $ sendAll conn (BS.pack gameStateStr)
    liftIO $ close conn

aeOpenSocket :: FilePath -> IO Socket
aeOpenSocket path = do
  sock <- socket AF_UNIX Stream 0
  bind sock (SockAddrUnix path)
  listen sock 5
  return sock

tick :: WorldM ()
tick = do
  world <- get
  let newWorld = updateWorld world
  put newWorld
