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
end

class ComputerPlayer
  attr_reader :board

  # def initialize
  #
  # end

  # def initialize(board)
  #   @board = board
  # end

  def display(board)
    @board = board
  end

  def get_play
    possible_shots = []
    (0...board.grid.length).each do |y|
      (0...board.grid.length).each do |x|
        pos = [x, y]
        if board[pos].nil? || board[pos] == :s
          possible_shots << pos
        end
      end
    end
    possible_shots.sample
  end

end
