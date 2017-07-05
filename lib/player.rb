class HumanPlayer
  attr_accessor :name

  def initialize(name = "Player")
    @name = name
  end

  def get_play
    puts "Where would you like to fire?"
    
    gets.chomp.split(",").map(&:to_i)
  end
end
