class DugwayServer
  HOST = '127.0.0.1'
  PORT = 9393

  attr_accessor :pid

  def boot
    if PortOpen.new.execute?(HOST, PORT)
      puts 'Booting Dugway Server'
      @pid = spawn("dugway server -h=#{HOST} -p=#{PORT}")

      AppBooted.new.execute?(HOST, PORT, 'Dugway', 5)
    end
  end

  def self.domain
    "http://#{HOST}:#{PORT}"
  end

  def kill_process
    Process.kill(3, @pid) if @pid
  end
end
