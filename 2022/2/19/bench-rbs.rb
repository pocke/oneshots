require 'benchmark/ips'
require 'stringio'

$LOAD_PATH << File.join(__dir__, "../lib")
require 'rbs'
require 'rbs/cli'

Benchmark.ips do |x|
  x.warmup = 10
  x.time = 20

  
  x.report('validate - core') { RBS::CLI.new(stdout: StringIO.new, stderr: StringIO.new).run(%w[validate --silent]) }
  x.report('method - core')   { RBS::CLI.new(stdout: StringIO.new, stderr: StringIO.new).run(%w[method String gsub]) }
  x.report('validate - rails') { RBS::CLI.new(stdout: StringIO.new, stderr: StringIO.new).run(%w[--collection /tmp/tmp.lY97zkzVZr/rbs_collection.yaml validate --silent]) }
  x.report('method - rails')   { RBS::CLI.new(stdout: StringIO.new, stderr: StringIO.new).run(%w[--collection /tmp/tmp.lY97zkzVZr/rbs_collection.yaml method String gsub]) }
end
