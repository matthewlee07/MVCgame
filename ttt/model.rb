class Game
  attr_reader :board, :X, :O
  attr_accessor :symbol, :current_turn, :space, :difficulty

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @X = "X" #computer
    @O = "O" #human
    @symbol
    @current_turn = @O
    @space
    @difficulty
  end

  def set_difficulty(setting)
    @difficulty = setting
  end

  def switch_turns
    @current_turn = @current_turn == @X ? @O : @X
  end

  def move(space)
    @space = space
    @board[@space] = @current_turn
  end

  def get_computer_move
    space_available?(4) ? move(4) : move(get_best_space)
  end

  def space_available?(space)
    @board[space] != "X" && @board[space] != "O"
  end

  def get_best_space
    puts "random move"
    get_random_space
  end

  #receives board array, returns array of available spaces
  def get_available_spaces
    available_spaces = []
    @board.each do |space|
      available_spaces << space if space_available?(space.to_i)
    end
    return available_spaces
  end

  def get_random_space
    get_available_spaces.sample.to_i
  end

  def game_is_over
    winner || tie ? true : false
  end

  def winner
    [@board[0], @board[1], @board[2]].uniq.length == 1 ||
    [@board[3], @board[4], @board[5]].uniq.length == 1 ||
    [@board[6], @board[7], @board[8]].uniq.length == 1 ||
    [@board[0], @board[3], @board[6]].uniq.length == 1 ||
    [@board[1], @board[4], @board[7]].uniq.length == 1 ||
    [@board[2], @board[5], @board[8]].uniq.length == 1 ||
    [@board[0], @board[4], @board[8]].uniq.length == 1 ||
    [@board[2], @board[4], @board[6]].uniq.length == 1
  end

  def tie
    @board.all? { |space| space == "X" || space == "O" }
  end
end
