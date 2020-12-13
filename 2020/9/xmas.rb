
def check_valid(value, preamble, seen)
  window_start = seen.length - 1
  window_end = seen.length - preamble
  check_array = seen[window_end, window_start]
  check_array.each do |n1|
    n2 = value - n1
    if check_array.include? n2
      return true
    end
  end
  return false
end


def main
  preamble = 25
  seen = []
  File.open("input.txt").read.each_line do |line|
    num = line.to_i
    if seen.length < preamble
      seen.append(num)
    else
      if not check_valid(num, preamble, seen)
        return num
      end
      seen.append(num)
    end
  end
  return nil
end


def main2
  target = 15353384
  numbers = []
  File.open("input.txt").read.each_line do |line|
    numbers.append(line.to_i)
  end

  for i in (0...numbers.length)
    for j in (0...i)
      puts "----------"
      puts "j: #{j}, i: #{i}"
      sum = 0
      for k in (j..i)
        sum += numbers[k]
        puts "| Number: #{numbers[k]} | Sum: #{sum} |"
      end
      puts "sum is: #{sum}"

      if sum == target
        ans = numbers[j, i-1]
        ans = ans.sort
        return ans[0] + ans[ans.length-1]
      end
    end
  end
  return nil
end

puts main2