require_relative "board.rb"
require_relative "player.rb"
# require "byebug"


class BattleshipGame
  attr_reader :board, :player

  def initialize(player = HumanPlayer.new, board = Board.new)

    @board = board
    @player = player


  end

  def count
    board.count
  end

  def attack(pos)

    if board[pos] == :s
      @board[pos] = :x
      puts "BAM! You hit a ship!"
    else
      @board[pos] = :o
    end
  end



  def game_over?
    @board.won?
  end

  def play_turn
    pos = player.get_play
    p pos
    attack(pos)
  end

  def display_status
    board.display_board
    puts "There are #{count} ships left"
  end

  def play
    # debugger
    counter = 0
    @board.setup
    @player.display(board)
    board.display_board
    
    while !game_over?
      play_turn
      display_status
      counter += 1
    end
    puts "It took you #{counter} shots to sink the enemys fleet."
  end


end



if $0 == __FILE__
  puts "Would you like to play solo against a Computer?"
  input = gets.chomp.downcase.split('').first
  if input == "y"
    BattleshipGame.new.play
  else

    BattleshipGame.new(ComputerPlayer.new, Board.new).play
  end
end
