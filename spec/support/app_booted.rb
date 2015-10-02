require 'socket'
require 'timeout'

class AppBooted
  def execute?(ip, port, app_name='App', seconds=5)
    Timeout::timeout(seconds) do
      app_booted = false

      puts "Waiting for #{app_name} to boot"
      until app_booted do
        begin
          TCPSocket.new(ip, port).close
          app_booted = true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          app_booted = false
        end
        sleep 1
      end
      puts "#{app_name} has boot"
      app_booted
    end
  rescue Timeout::Error
    false
  end
end
