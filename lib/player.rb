require_relative "board.rb"

class HumanPlayer
  attr_accessor :name

  def initialize(name = "Player")
    @name = name
  end

  def get_play
    puts "Where would you like to fire?"
    # [1, 1]#gets.chomp
    gets.chomp.split(",").map(&:to_i)
  end

  def display(board)
  end
end

class ComputerPlayer
  attr_reader :board

  def initialize
    @hits = []
    @possible_shots = []
    @good_shots = []
  end



  def display(board)
    @board = board
  end

  def find_possible_shots
    # @possible_shots = []
    (0...board.grid.length).each do |y|
      (0...board.grid.length).each do |x|
        pos = [x, y]
        if board[pos].nil? || board[pos] == :s
          @possible_shots << pos # unless @possible_shots.include?(pos)
        elsif board[pos] == :x
          @hits << pos unless @hits.include?(pos)
        end
      end
    end
  end

  def find_good_shots(pos)
    x, y = pos

    if @possible_shots.include?([x + 1, y])
      @good_shots << [x + 1, y] #unless (x > board.grid.length - 1)
    end
    if @possible_shots.include?([x - 1, y])
      @good_shots << [x - 1, y] #unless (x > board.grid.length - 1) || (x - 1) < 0
    end
    if @possible_shots.include?([x, y - 1])
      @good_shots << [x, y - 1] #unless (y > board.grid.length - 1) || (y - 1) < 0
    end
    if @possible_shots.include?([x, y + 1])
      @good_shots << [x, y + 1] #unless (y > board.grid.length - 1) || x < 0
    end

  end



  def get_play
    find_possible_shots
    if !@hits.empty?
      @hits.each do |pos|
        find_good_shots(pos)
      end
    end
    if !@good_shots.empty?
      pos = @good_shots.sample
    else
      pos = @possible_shots.sample
    end

    @good_shots.reject! { |el| el == pos }
    @possible_shots.reject! { |el| el == pos }
    pos
  end

end
