require_relative "board.rb"
require_relative "player.rb"


class BattleshipGame
  attr_reader :board, :player

  def initialize(board = Board.new, player = HumanPlayer.new)

    @board = Board.new
    @player = HumanPlayer.new
    2.times { @board.place_random_ship }

  end

  def count
    board.count
  end

  def attack(pos)
    # should raise Error here if there is an invalid input
    if board[pos] == :s
      @board[pos] = :x
      puts "BAM! You hit a ship!"
    else
      @board[pos] = :x
    end
  end

  def game_over?
    @board.won?
  end

  def play_turn
    pos = player.get_play
    # pos = [1, 1]
    attack(pos)
  end

  def display_status
    board.display_board
    puts "There are #{count} ships left"
  end

  def play
    board.display_board
    while !game_over?
      play_turn
      display_status
    end
  end


end



if $0 == __FILE__
  # player = HumanPlayer.new
  # board = Board.new
  BattleshipGame.new.play
end
