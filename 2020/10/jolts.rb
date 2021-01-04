
def main
  adapters = []
  File.open("input.txt").read.each_line do |line|
    adapters.append(line.to_i)
  end
  adapters = adapters.sort

  one_jolts = 0
  two_jolts = 0
  three_jolts = 0

  prev = 0
  for i in (0...adapters.length)
    cur = adapters[i]
    diff = cur - prev
    
    if diff == 1
      one_jolts += 1
    elsif diff == 2
      two_jolts += 1
    elsif diff == 3
      three_jolts += 1  
    end

    prev = cur
  end

  # defualt three jolt jump
  three_jolts += 1

  return (one_jolts * three_jolts)
end


$adapters = [0]
$cache = {}

def recursive_search(position)
  if position == $adapters.length-1
    return 1
  end

  if $cache.key?(position)
    return $cache[position]
  end

  possiblities = 0
  next_pos = position + 1
  while $adapters[next_pos] <= $adapters[position] + 3
    possiblities += recursive_search(next_pos)
    next_pos += 1
    if next_pos >= $adapters.length
      break
    end
  end
  $cache[position] = possiblities
  return possiblities
end


def main2
  File.open("input.txt").read.each_line do |line|
    $adapters.append(line.to_i)
  end
  $adapters = $adapters.sort
  cur_pos = 0
  return recursive_search(cur_pos)
end

puts main2