class Board
  attr_accessor :grid

  SHIPS = {
    aircraft_carrier: 5,
    battleship: 4,
    destroyer: 3,
    patrol_boat: 2
  }

  def initialize(grid = self.class.default_grid)
    @grid = grid
    @initial_ships = []
  end

  def random_ship
    SHIPS[SHIPS.keys.sample]
  end

  def extend_ship(position, direction = nil, size = nil)
    # this should be option hash, will change it later
    possible_ships = []
    x, y = position
    if direction == nil
      orientation = random_direction
    end
    if size.nil?
      size = random_ship
    end
    if orientation == "n"
      (size - 1).times do
        x -= 1
        possible_ships << [x, y]
      end

    elsif orientation == "s"
      (size - 1).times do
        x += 1
        possible_ships << [x, y]
      end

    elsif orientation == "e"
      (size - 1).times do
        y += 1
        possible_ships << [x, y]
      end

    else
      (size - 1).times do
        y -= 1
        possible_ships << [x, y]
      end
    end
    if x.between?(0, @grid.length - 1) && y.between?(0, @grid.length - 1)
      if possible_ships.all? { |pos| self[pos].nil? } &&
        possible_ships.each { |pos| self[pos] = :s }
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def setup(ship_count = nil)
    if ship_count.nil?
      ship_count = 5
    end
    ship_count.times do
      place_random_ship
    end
    @initial_ships.each do |pos|
      until extend_ship(pos)
        next
      end
    end
  end

  def random_direction
    ["n", "s", "e", "w"].sample
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def count

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
        @initial_ships << pos
      end
    end
  end

  def won?
    count == 0
  end

  def display_board
    # the print ships is disabled. can be enabled for testing
    print "_" * @grid.length * 4
    puts ""
    @grid.each do |row|
      row.each do |pos|
        if pos == :x
          print "| x |"
        elsif pos == :o
          print "| o |"
        elsif pos == :s
          print "| s |"
        else
          print "|   |"
        end
      end
      print "\n"

    end
  end

end
