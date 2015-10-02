require 'socket'
require 'timeout'

class PortOpen
  def execute?(ip, port, seconds=1)
    $stdout.sync = true

    Timeout::timeout(seconds) do
      print 'Checking if port open...'
      begin
        TCPSocket.new(ip, port).close
        false
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        puts ' ✓'
        true
      end
    end
  rescue Timeout::Error
    false
  end
end
