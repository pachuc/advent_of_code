=begin
Due to the local geology, trees in this area only grow on exact integer coordinates in a grid. 
You make a map (your puzzle input) of the open squares (.) and trees (#) you can see.
Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?
=end

class Toboggan

    attr_reader :trees_hit
    def initialize(input_string)
        @terrain = []
        @xpos = 0
        @ypos = 0
        @width = 0
        @trees_hit = 0
        
        for line in input_string.each_line()
            cells = line.split("")
            cells.pop()
            @terrain.append(cells)
            if @width == 0
                @width = cells.length()
            end
        end

        @height = @terrain.length()
    end

    def get_cell(x, y)
        return @terrain[y][x]
    end

    def check_tree()
        if get_cell(@xpos, @ypos) == "#"
            @trees_hit += 1
        end
    end

    def reset()
        @trees_hit = 0
        @xpos = 0
        @ypos = 0
    end

    def move_right()
        @xpos += 1
        if @xpos == @width
            @xpos = 0
        end
    end

    def move_down()
        @ypos += 1
    end

    def doMoves(right, down)
        for i in (0..right-1)
            move_right()
        end

        for i in (0..down-1)
            move_down()
        end
        
        if not past_bottom()
            check_tree()
        end
    end

    def past_bottom()
        if @ypos >= @height
            return true
        end
        return false
    end

end

def count_trees1()
    text = File.open('input.txt').read()
    tob = Toboggan.new(text)
    while tob.past_bottom() == false
        tob.doMoves(3, 1)
    end
    return tob.trees_hit
end

=begin
Determine the number of trees you would encounter if, for each of the following slopes, 
you start at the top-left corner and traverse the map all the way to the bottom:

Right 1, down 1.
Right 3, down 1. (This is the slope you already checked.)
Right 5, down 1.
Right 7, down 1.
Right 1, down 2.

=end

def count_trees2()
    answer = 1
    paths = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    text = File.open('input.txt').read()
    tob = Toboggan.new(text)
    for path in paths
        tob.reset()
        while tob.past_bottom() == false
            tob.doMoves(path[0], path[1])
        end
        answer *= tob.trees_hit
    end
    return answer
end

puts count_trees2()