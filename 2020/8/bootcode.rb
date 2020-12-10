$accumulator = 0
$position = 0
$seen = []

def parse_instruction(instruction)
  cmd, offset = instruction.scan(/\w\w\w|[+-]\d+/)
  offset = offset.to_i
  return cmd, offset
end


def run_instruction(instruction)
  $seen.append($position)
  cmd, offset = parse_instruction(instruction)
  if cmd == "nop"
    $position += 1
    return
  end

  if cmd == "acc"
    $accumulator += offset
    $position += 1
    return
  end

  if cmd == "jmp"
    $position += offset
    return
  end
end


def main
  instructions = File.readlines("input.txt")
  while $position < instructions.length and not $seen.include? $position
    run_instruction(instructions[$position])
  end
  puts "Final Accumulator Value: #{$accumulator}"
end


def main2
  instructions = File.readlines("input.txt")
  while $position < instructions.length
    puts $position+1
    if $seen.include? $position
      puts "Breaking, repeated position"
      break
    end
    run_instruction(instructions[$position])
  end
  puts "Final Accumulator Value: #{$accumulator}"
end

main2