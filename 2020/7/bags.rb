$rules = {}

def parse_rule1(rule_text)
    rule_text = rule_text.chomp
    rule = rule_text.split("contain")
    outer = rule[0]
    outer = outer.strip
    outer = outer.delete_suffix("s")
    inner = rule[1]
    inner = inner.delete_suffix(".")

    if inner == "no other bags"
        return
    end

    inner_rules = inner.split(",")
    inner_rules.each do |ir|
        ir = ir.strip
        num = ir.scan(/\d+ /)[0]
        if num == nil
            num = ""
        end
        ir.slice! num
        ir = ir.delete_suffix("s")
        num = num.to_i
        if $rules.key?(ir)
            $rules[ir].append(outer)
        else
            $rules[ir] = [outer]
        end
    end
end

def main1
    File.open("input.txt").read.each_line do |line|
        parse_rule1(line)
    end

    to_check = ["shiny gold bag"]
    checked = []
    while to_check.length != 0
        bag = to_check.pop()
        if checked.include? bag
            next
        end
        checked.append(bag)
        if $rules.key? bag
            to_check = to_check + $rules[bag]
        end 
    end

    puts checked.length - 1
end


def parse_rule2(rule_text)
    rule_text = rule_text.chomp
    rule = rule_text.split("contain")
    outer = rule[0]
    outer = outer.strip
    outer = outer.delete_suffix("s")
    inner = rule[1]
    inner = inner.delete_suffix(".")
    inner = inner.strip

    if inner == "no other bags"
        return
    end

    parsed_inner = {}
    inner_rules = inner.split(",")
    inner_rules.each do |ir|
        ir = ir.strip
        num = ir.scan(/\d+ /)[0]
        if num == nil
            num = ""
        end
        ir.slice! num
        ir = ir.delete_suffix("s")
        num = num.to_i
        parsed_inner[ir] = num
    end
    $rules[outer] = parsed_inner
end

def recurse_search(bag)
    if not $rules.key?(bag)
        return 1
    end
    bags_to_check = $rules[bag]
    total_bags = 0
    bags_to_check.each do |key, value|
        total_bags += value * recurse_search(key)
    end
    return (total_bags+1)
end

def main2
    File.open("input.txt").read.each_line do |line|
        parse_rule2(line)
    end
    val = recurse_search("shiny gold bag")
    puts val-1
end

main2
