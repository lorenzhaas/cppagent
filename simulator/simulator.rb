
require 'socket'
require 'net/http'
require 'readline'
require 'time'

puts "Waiting for connection..."

server = TCPServer.new(7878)
loop do
  socket = server.accept
  puts "Client connected"
  puts "Type an adapter feed string in the following format:"
  puts "> <key>|<value>"
  puts "> <key>|<value>|<key>|<value> ..."
  puts "> <alarm>|<code>|<native code>|<severity:CRITICAL|ERROR|WARNING|INFO>|<state:ACTIVE|CLEARED|INSTANT>|<message>"
  loop do
    line = Readline::readline('> ')
    Readline::HISTORY.push(line)

    ts = Time.now.utc
    stamp = "#{ts.iso8601[0..-2]}.#{'%06d' % ts.tv_usec}"
    puts "#{stamp}|#{line}"
    socket.write "#{stamp}|#{line}\n"
  end
end
