=begin

The automatic passport scanners are slow because they're having trouble detecting which passports have all required fields. 
The expected fields are as follows:

byr (Birth Year)
iyr (Issue Year)
eyr (Expiration Year)
hgt (Height)
hcl (Hair Color)
ecl (Eye Color)
pid (Passport ID)
cid (Country ID)
Passport data is validated in batch files (your puzzle input). 
Each passport is represented as a sequence of key:value pairs separated by spaces or newlines. 
Passports are separated by blank lines.

=end

def reset_passport()
    $passport = {
        "byr" => false,
        "iyr" => false,
        "eyr" => false,
        "hgt" => false,
        "hcl" => false,
        "ecl" => false,
        "pid" => false,
        "cid" => false,
    }
end

def check_valid_passport()
    if $passport["byr"] and $passport["iyr"] and $passport["eyr"] and $passport["hgt"] and $passport["hcl"] and $passport["ecl"] and $passport["pid"]
        return true
    end
    return false
end


def parse_passports1()
    valid_passports = 0
    reset_passport()
    for line in File.open('input.txt').read().each_line()
        # new pssport
        if line == "\n"
            if check_valid_passport()
                valid_passports += 1
            end
            reset_passport()
        else
            fields = line.chomp().split(" ")
            for f in fields
                key, value = f.split(":")
                $passport[key] = true
            end
        end
    end
    if check_valid_passport()
        valid_passports += 1
    end
    return valid_passports
end

=begin
--- Part Two ---
The line is moving more quickly now, but you overhear airport security talking about how passports with invalid data are getting through. Better add some data validation, quick!

You can continue to ignore the cid field, but each other field has strict rules about what values are valid for automatic validation:

byr (Birth Year) - four digits; at least 1920 and at most 2002.
iyr (Issue Year) - four digits; at least 2010 and at most 2020.
eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
hgt (Height) - a number followed by either cm or in:
If cm, the number must be at least 150 and at most 193.
If in, the number must be at least 59 and at most 76.
hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
pid (Passport ID) - a nine-digit number, including leading zeroes.
cid (Country ID) - ignored, missing or not.

Your job is to count the passports where all required fields are both present and valid according to the above rules.
=end

def check_year(v, min, max)
    if /^\d\d\d\d$/.match?(v)
        year = v.to_i
        if year >= min and year <= max
            return true
        end
    end
    return false
end

def validate_field(key, value)

    if key == "byr"
        return check_year(value, 1920, 2002)
    end

    if key == "iyr"
        return check_year(value, 2010, 2020)
    end

    if key == "eyr"
        return check_year(value, 2020, 2030)
    end

    if key == "hgt"
        if /^\d+cm$/.match?(value)
            h = value.delete_suffix("cm")
            h = h.to_i
            if h >= 150 and h <= 193
                return true
            end
        end

        if /^\d+in$/.match?(value)
            h = value.delete_suffix("in")
            h = h.to_i
            if h >= 59 and h <= 76
                return true
            end
        end

        return false
    end

    if key == "hcl"
        if /^#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$/.match?(value)
            return true
        end
        return false
    end

    if key == "ecl"
        eye_colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        if eye_colors.include? value
            return true
        end
        return false
    end

    if key == "pid"
        if /^\d\d\d\d\d\d\d\d\d$/.match?(value)
            return true
        end
        return false
    end

    if key == "cid"
        return true
    end

end


def parse_passports2()
    valid_passports = 0
    reset_passport()
    for line in File.open('input.txt').read().each_line()
        # new pssport
        if line == "\n"
            if check_valid_passport()
                valid_passports += 1
            end
            reset_passport()
        else
            fields = line.chomp().split(" ")
            for f in fields
                key, value = f.split(":")
                if validate_field(key, value)
                    $passport[key] = true
                end
            end
        end
    end
    if check_valid_passport()
        valid_passports += 1
    end
    return valid_passports
end


puts parse_passports2