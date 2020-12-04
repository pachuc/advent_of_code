=begin
Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); 
apparently, something isn't quite adding up.

Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.

For example, suppose your expense report contained the following:

1721
979
366
299
675
1456
In this list, the two entries that sum to 2020 are 1721 and 299. 
Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

Of course, your expense report is much larger. 
Find the two entries that sum to 2020; what do you get if you multiply them together?
=end


def parse_expense_report_two()
    values = []
    text = File.open('input.txt').read()
    text.each_line() do |line|
        current = line.to_i
        target = 2020 - current
        if values.include? target
            return (target * current)
        end
        values.append(current)
    end
end

=begin
part 2, find 3 numbers that add up to 2020
=end

def parse_expense_report_three()
    values = []
    text = File.open('input.txt').read()
    text.each_line() do |line|
        if line != nil
            values.append(line.to_i)
        end
    end
    values = values.sort()

    for i in (2..values.length())
        for j in (1..i)
            for k in (0..j)
                puts "trying (#{i}, #{j}, #{k})"
                total = values[i] + values[j] + values[k]
                puts "total is #{total}"
                if total == 2020
                    return (values[i] * values[j] * values[k])
                end
            end
        end
    end
end

puts parse_expense_report_three()