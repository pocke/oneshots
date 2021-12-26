def rss
  pid = spawn('ruby', '-Ilib', '-e', 'sleep', 2 => '/dev/null')
  sleep 0.1
  # It prints the following (with header):
  # USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
  # root           1  0.0  0.0 165332 11072 ?        Ss   Dec03   0:10 /sbin/init
  rss = `ps u --no-headers --pid #{pid}`.split(' ')[5].to_i
  Process.kill :INT, pid
  rss
end

N = 100
mems = N.times.map { rss }.sort
puts "avg: #{mems.sum.to_f / N}, mid: #{mems[N/2]}, min: #{mems.first}, max: #{mems.last}"
