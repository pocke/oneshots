require 'pathname'

print 'Type the file name > '
name = gets.chomp

now = Time.now

dir = Pathname("#{now.year}/#{now.month}/#{now.day}").tap(&:mkpath)
path = dir.join(name)
path.write ''
puts "Created: #{path}"
