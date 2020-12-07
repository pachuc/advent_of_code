=begin
You write a quick program to use your phone's camera to scan all of the nearby boarding passes (your puzzle input); 
perhaps you can find your seat through process of elimination.

Instead of zones or groups, this airline uses binary space partitioning to seat people. 
A seat might be specified like FBFBBFFRLR, where F means "front", B means "back", L means "left", and R means "right".

The first 7 characters will either be F or B; these specify exactly one of the 128 rows 
on the plane (numbered 0 through 127). Each letter tells you which half of a region the 
given seat is in. Start with the whole list of rows; the first letter indicates whether 
the seat is in the front (0 through 63) or the back (64 through 127). The next letter indicates 
which half of that region the seat is in, and so on until you're left with exactly one row.

For example, consider just the first seven characters of FBFBBFFRLR:

Start by considering the whole range, rows 0 through 127.
F means to take the lower half, keeping rows 0 through 63.
B means to take the upper half, keeping rows 32 through 63.
F means to take the lower half, keeping rows 32 through 47.
B means to take the upper half, keeping rows 40 through 47.
B keeps rows 44 through 47.
F keeps rows 44 through 45.
The final F keeps the lower of the two, row 44.
The last three characters will be either L or R; these specify exactly one of the 8 columns 
of seats on the plane (numbered 0 through 7). The same process as above proceeds again, 
this time with only three steps. L means to keep the lower half, while R means to keep the upper half.

For example, consider just the last 3 characters of FBFBBFFRLR:

Start by considering the whole range, columns 0 through 7.
R means to take the upper half, keeping columns 4 through 7.
L means to take the lower half, keeping columns 4 through 5.
The final R keeps the upper of the two, column 5.
So, decoding FBFBBFFRLR reveals that it is the seat at row 44, column 5.

Every seat also has a unique seat ID: multiply the row by 8, then add the column. 
In this example, the seat has ID 44 * 8 + 5 = 357.
=end

def string_to_rc(input_str)
    input_arr = input_str.chomp.split("")
    row_input = input_arr.slice(0, 7)
    col_input = input_arr.slice(7, 9)
    row = bin_search_seat(row_input, 0, 128, "F", "B")
    col = bin_search_seat(col_input, 0, 8, "L", "R")
    return row, col
end


def bin_search_seat(input_arr, min, max, min_letter, max_letter)

    for r in input_arr
        midway = (min + max)/2
        if r == min_letter
            max = midway
        end
        if r == max_letter
            min = midway
        end
    end

    return (min + max) / 2
end


def generate_seat_id(row, col)
    return (row * 8) + col
end


def main
    max_seat_id = 0
    File.open('input.txt').read().each_line() do |line|
        row, col = string_to_rc(line)
        seat_id = generate_seat_id(row, col)
        if seat_id >= max_seat_id
            max_seat_id = seat_id
        end
    end
    puts max_seat_id
end


=begin
--- Part Two ---
Ding! The "fasten seat belt" signs have turned on. Time to find your seat.

It's a completely full flight, so your seat should be the only missing boarding pass in your list. 
However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, 
so they'll be missing from your list as well.

Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.

What is the ID of your seat?
=end

def gen_seat_grid()
    grid = []
    for i in (0..127)
        arr = ["_"] * 8
        grid.append(arr)
    end
    return grid
end


def main2()
    grid = gen_seat_grid
    File.open('input.txt').read().each_line() do |line|
        row, col = string_to_rc(line)
        grid[row-1][col-1] = "X"
    end

    first_row = nil
    last_row = nil
    for i in (0..127)
        if first_row == nil
            for j in (0..7)
                if grid[i][j] == "X"
                    first_row = i
                    last_row = i
                    break
                end
            end
        else
            for j in (0..7)
                if grid[i][j] == "X"
                    last_row = i
                    break
                end
            end
        end
    end

    row = nil
    col = nil
    for i in (first_row+1..last_row-1)
        for j in (0..7)
            if grid[i][j] == "_"
                row = i + 1
                col = j + 1
                # break
            end
        end
        #if row != nil
        #    break
        #end
    end
    puts row
    puts col
    puts generate_seat_id(row, col)
end

main2