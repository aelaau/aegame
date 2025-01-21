require 'socket'

socket_path = "/tmp/aesock"
begin
  # Connect to the Unix socket
  socket = UNIXSocket.new(socket_path)
  # Read the message from the Haskell server
  message = socket.read
  puts "Received message: #{message}"
rescue => e
  puts "Error: #{e.message}"
ensure
  socket.close if socket
end
