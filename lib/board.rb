class Board
  attr_accessor :grid

  def initialize(grid = self.class.default_grid)
    @grid = grid
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def count
    # grid.flatten.count(&:nil?) # cannot put the ! anywhere.
    # nil isnt the right thing to look for but interesting problem
    grid.flatten.count { |el| el == :s }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, mark)
    x, y = pos
    @grid[x][y] = mark
  end

  def empty?(pos = nil)
    if pos
      return self[pos].nil?
    else
      return count == 0
    end
  end

  def full?
    count == (grid.length * grid.length)
  end

  def place_random_ship
    raise "Board is full" if full?
    number_ships = count
    while number_ships == count
      pos = [rand(grid.length), rand(grid.length)]
      if empty?(pos)
        grid[pos[0]][pos[1]] = :s
      end
    end
  end

  def won?
    count == 0
  end

  def display_board
    print "_" * @grid.length * 7
    puts ""
    @grid.each do |row|
      row.each do |pos|
        if pos == :x
          print " | x | "
        else
          print " |   | "
        end
      end
      print "\n"
    end
  end

end
