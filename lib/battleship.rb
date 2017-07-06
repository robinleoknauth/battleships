require_relative "board.rb"
require_relative "player.rb"


class BattleshipGame
  attr_reader :board, :player

  def initialize(player = HumanPlayer.new, board = Board.new)

    @board = board
    @player = player
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
      @board[pos] = :o
    end
  end

  # def setup
  #   puts "Would you like to play solo against a Computer?"
  #   input = gets.chomp.downcase.split('').first
  #   if input == "y"
  #     play
  #   end
  # end

  def game_over?
    @board.won?
  end

  def play_turn
    pos = player.get_play
    attack(pos)
  end

  def display_status
    board.display_board
    puts "There are #{count} ships left"
  end

  def play
    @player.display(board)
    board.display_board
    while !game_over?
      play_turn
      display_status
    end
  end


end



if $0 == __FILE__
  puts "Would you like to play solo against a Computer?"
  input = gets.chomp.downcase.split('').first
  if input == "y"
    BattleshipGame.new.play
  else
    # BattleshipGame.new(ComputerPlayer.new, Board.new).play
    BattleshipGame.new(ComputerPlayer.new, Board.new).play
  end
end
