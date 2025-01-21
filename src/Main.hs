module Main(main) where

import Network.Socket
import Network.Socket.ByteString (sendAll)
import qualified Data.ByteString.Char8 as BS
import Control.Exception (bracket)
import Control.Monad (forever)

import World
import Player

main :: IO ()
main = do
  let game = initializeGame (Player "Player 1" 100)
  let updatedGame = startGame game
  print updatedGame

socketStart :: IO ()
socketStart = do
  let socketPath = "/tmp/aesock"
  bracket (aeOpenSocket socketPath) close $ \sock -> do
    putStrLn $ "Socket opened: " ++ socketPath
    forever $ do
      (conn, _) <- accept sock
      sendAll conn (BS.pack "Hello, world!")
      close conn

aeOpenSocket :: FilePath -> IO Socket
aeOpenSocket path = do
  sock <- socket AF_UNIX Stream 0
  bind sock (SockAddrUnix path)
  listen sock 5
  return sock
