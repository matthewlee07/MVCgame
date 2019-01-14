class Game
  attr_reader :board, :X, :O
  attr_accessor :symbol, :current_turn, :space, :difficulty

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @X = "X" #computer
    @O = "O" #human
    @symbol
    @current_turn = @O
    @spot
    @difficulty
  end

  def set_difficulty(setting)
    @difficulty = setting
  end

  def switch_turns
    @current_turn = @current_turn == @X ? @O : @X
  end

  def move(space)
    @spot = space
    @board[@spot] = @current_turn
  end

  def get_computer_move
    space_available?(4) ? @board[4] = @current_turn : @board[get_best_space] = @current_turn
  end

  def space_available?(space)
    @board[space] != "X" && @board[space] != "O"
  end

  # def get_best_space
  #   available_spaces = get_available_spaces
  #   if @difficulty == 1
  #     best_move = nil
  #     available_spaces.each do |space|
  #       best_move = space.to_i
  #       @board[best_move] = @current_turn
  #       if winning_space?(space)
  #         puts "winnging move"
  #         @board[space.to_i] = space
  #         return best_move
  #       elsif block_win?(space)
  #         puts "block move"
  #         @board[space.to_i] = space
  #         return best_move
  #       elsif block_fork?(space)
  #         puts "block fork move"
  #         @board[space.to_i] = space
  #         return best_move
  #       else
  #         @board[best_move] = space
  #       end
  #     end
  #   end
  #   puts "random move"
  #   get_random_space
  # end

  # def winning_space?(space)
  #   puts "checking winning #{@current_turn} move"
  #   move(space.to_i)
  #   winner
  # end
  # --------------------------
  def get_best_space
    best_space = get_random_space
    if @difficulty == 1
      # if any of the spaces is a winner then return best_space
      if winning_space?
        return best_space
        # elseif any of the spaces is a block_win then return best_space
        # elsif block_win?
        #   return best_space
        #   # elseif any of the spaces is a block_fork then return best space
        # elsif block_fork?
        #   return best_space
      end
    end
    best_space
  end

  # receives array of available spaces
  # returns boolean of if there's a space which will win
  def winning_space?
    available_spaces = get_available_spaces
    available_spaces.each do |space|
      puts "checking winning #{@current_turn} move: #{space}"
      move(space.to_i)
      if winner
        return true
      else
        puts "replace board..."
        @board[space.to_i] = space
        puts @board
      end
    end
    return false
  end

  # --------------------------
  def block_win?(space)
    puts "checking blocking move"
    switch_turns
    move(space.to_i)
    switch_turns
    winner
  end

  def block_fork?(space)
  end

  #receives board array, returns array of available spaces
  def get_available_spaces
    available_spaces = []
    @board.each do |space|
      # available_spaces << space if space_available?(space.to_i)
      if space != "X" && space != "O"
        available_spaces << space
      end
    end
    return available_spaces
  end

  def get_random_space
    return get_available_spaces.sample.to_i
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
