=begin
abc

a
b
c

ab
ac

a
a
a
a

b

This list represents answers from five groups:

The first group contains one person who answered "yes" to 3 questions: a, b, and c.
The second group contains three people; combined, they answered "yes" to 3 questions: a, b, and c.
The third group contains two people; combined, they answered "yes" to 3 questions: a, b, and c.
The fourth group contains four people; combined, they answered "yes" to only 1 question, a.
The last group contains one person who answered "yes" to only 1 question, b.
In this example, the sum of these counts is 3 + 3 + 3 + 1 + 1 = 11.

For each group, count the number of questions to which anyone answered "yes". What is the sum of those counts?
=end


def main
    counts = []
    questions = []
    File.open("input.txt").read.each_line do |line|
        if line == "\n"
            c = questions.length
            counts.append(c)
            questions = []
        else
            line = line.chomp
            letters = line.split("")
            letters.each do |l|
                if not questions.include? l
                    questions.append(l)
                end
            end
        end
        
    end

    sum = 0
    counts.each do |c|
        sum += c
    end
    puts sum
end

=begin
--- Part Two ---
As you finish the last group's customs declaration, you notice that you misread one word in the instructions:

You don't need to identify the questions to which anyone answered "yes"; 
you need to identify the questions to which everyone answered "yes"!
=end

def main2
    counts = []
    questions = []
    questions_set = false
    File.open("input.txt").read.each_line do |line|
        if line == "\n"
            c = questions.length
            counts.append(c)
            questions = []
            questions_set = false
        else
            line = line.chomp
            line = line.downcase
            if not /^[a-z]+$/.match(line)
                raise Exception.new "fuck"
            end
            letters = line.split("")
            if not questions_set
                letters.each do |l|
                    if not questions.include? l
                        questions.append(l)
                    end
                end
                questions_set = true
            else
                new_questions = questions.clone
                questions.each do |l|
                    if not letters.include? l
                        new_questions.delete(l)
                    end
                end
                questions = new_questions
            end
        end
        
    end

    sum = 0
    counts.each do |c|
        sum += c
    end
    puts sum
end

main2