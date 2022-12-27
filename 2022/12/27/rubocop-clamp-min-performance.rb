require 'benchmark/ips'

require 'benchmark'
Benchmark.ips do |x|
  a = 42
  b = 43

  x.report('ops') { a > b ? b : a }
  x.report('min') { [a, b].min }
  x.report('clamp') { a.clamp(..b) }

  x.compare!
end
