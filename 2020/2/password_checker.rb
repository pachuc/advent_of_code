=begin
The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. 
"Something's wrong with our computers; we can't log in!" You ask if you can take a look.

Their password database seems to be a little corrupted: some of the passwords wouldn't 
have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.

To try to debug the problem, they have created a list (your puzzle input) of passwords 
(according to the corrupted database) and the corporate policy when that password was set.

For example, suppose you have the following list:

1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
Each line gives the password policy and then the password. 
The password policy indicates the lowest and highest number of times a given letter must 
appear for the password to be valid. For example, 1-3 a means that the password must 
contain a at least 1 time and at most 3 times.

In the above example, 2 passwords are valid. The middle password, cdefg, is not; 
it contains no instances of b, but needs at least 1. 
The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

How many passwords are valid according to their policies?
=end


def check_passwords
    valid_passwords = 0
    text = File.open('input.txt').read()
    text.each_line() do |line|
        rule, letter, password = line.split(" ")
        min, max = rule.split("-")
        min = min.to_i
        max = max.to_i
        letter = letter.delete_suffix(":")
        letter_count = 0
        password.each_char do |c|
            if c == letter
                letter_count += 1
            end
        end
        if letter_count >= min and letter_count <= max
            valid_passwords += 1
        end
    end
    return valid_passwords
end

=begin
Each policy actually describes two positions in the password, 
where 1 means the first character, 2 means the second character, and so on. 
(Be careful; Toboggan Corporate Policies have no concept of "index zero"!) 
Exactly one of these positions must contain the given letter. 
Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

Given the same example list from above:

1-3 a: abcde is valid: position 1 contains a and position 3 does not.
1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.

How many passwords are valid according to the new interpretation of the policies?
=end

def check_passwords2
    valid_passwords = 0
    text = File.open('input.txt').read()
    text.each_line() do |line|
        rule, letter, password = line.split(" ")
        one, two = rule.split("-")
        one = one.to_i - 1
        two = two.to_i - 1
        letter = letter.delete_suffix(":")

        chars = password.split("")
        if chars[one] == letter and chars[two] != letter
            valid_passwords += 1
        elsif chars[one] != letter and chars[two] == letter
            valid_passwords += 1
        end
    end
    return valid_passwords
end

puts check_passwords2()
