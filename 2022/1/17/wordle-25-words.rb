input = File.foreach('/usr/share/dict/american-english')
# input = ["abcde", 'fghij', 'klmno', 'pqrst', 'uvwxy'] # debug

arr = input
  .map(&:chomp).map(&:downcase)
  .select { _1.size == 5 }
  .uniq
  .reject { _1.chars.uniq.size != 5 }
  .select { /[a-z]{5}/.match? _1 }
  .map { [_1, _1.chars.map { |n| n.ord-97 }.inject(0) { |r, n| r | (2**n)}] }

# arr = arr.shuffle[0..1000] # debug

hash = arr
  .group_by { _2 }
  .transform_values { _1.map { |x, _| x } }


p hash.first
p hash.size
words = hash.keys

SIZE = words.size

def check(words, sum, level)
  return if level == 5

  res = false
  words.each.with_index do |w, idx|
    if sum & w == 0
      r = check words[idx+1, SIZE], sum | w, level + 1
      next if r == false
      res = [w, *r]
      break
    end
  end
  res
end

def main(words)
  r = check words, 0, 0
  if r
    puts 'found'
    p r.map { hash[_1] }
  else
    puts 'not found'
  end
end

def main2(words)
  words2 = words.combination(2).filter_map { |w1, w2| w1 | w2 if w1 & w2 == 0 }
  p words2.size
end

main2 words
