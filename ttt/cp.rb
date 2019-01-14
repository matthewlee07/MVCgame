# receives nothing
# returns integer to be used by @board[get_best_space] = @current_turn
#

def get_best_space
  best_space = nil
  if @difficulty == 1
    # if any of the spaces is a winner then return best_space
    if winning_space?
      return best_space
      # elseif any of the spaces is a block_win then return best_space
    elsif block_win?
      return best_space
      # elseif any of the spaces is a block_fork then return best space
    elsif block_fork?
      return best_space
    end
  end
  best_space ? move(best_space) : move(get_random_space)
end

# receives array of available spaces
# returns boolean of if there's a space which will win
def winning_space?
  available_spaces = get_available_spaces
  available_spaces.each do |space|
    puts "checking winning #{@current_turn} move: #{space}"
    move(space.to_i)
    return true if winner
  end
  return false
end

# available_spaces = get_available_spaces
# if @difficulty == 1
#   best_space = nil
#   available_spaces.each do |space|
#     best_space = space.to_i
#     @board[best_space] = @current_turn
#     if winning_move?(space)
#       puts "winnging move"
#       @board[space.to_i] = space
#       return best_space
#     elsif block_win?(space)
#       puts "block move"
#       @board[space.to_i] = space
#       return best_space
#     elsif block_fork?(space)
#       puts "block fork move"
#       @board[space.to_i] = space
#       return best_space
#     else
#       @board[best_space] = space
#     end
#   end
# end
# puts "random move"
# get_random_space(available_spaces)
