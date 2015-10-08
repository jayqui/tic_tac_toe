class Game

  attr_accessor :board, :human_mark, :computer_mark, :winner

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @computer_mark = "X"
    @human_mark = "O"
  end

  def combinations
    [ [board[0], board[1], board[2]],
      [board[3], board[4], board[5]],
      [board[6], board[7], board[8]],
      [board[0], board[3], board[6]],
      [board[1], board[4], board[7]],
      [board[2], board[5], board[8]],
      [board[0], board[4], board[8]],
      [board[2], board[4], board[6]] ]
  end

  def generate_computer_move
    spot = nil

    until spot
      # prefer middle if empty
      if board[4] == "4"
        spot = 4
        board[spot] = computer_mark
      else
        spot = get_best_move(board, computer_mark)
        if board[spot] != computer_mark && board[spot] != human_mark
          board[spot] = computer_mark
        else
          spot = nil
        end
      end
    end
    return spot
  end

  def find_available_spaces(board)
    board.select { |s| s != computer_mark && s != human_mark}    
  end

  def revert_to(original_board) # put back after simluating
    self.board = original_board
  end

  def declare_best_move_and_end_simulation(player, as, original_board)
    best_move = as
    revert_to(original_board)
    return best_move
    # if player == computer_mark
    #   return {as => 100}
    # elsif player == human_mark
    #   return {as => -100}
    # end
  end

  def other_player(current_player)
    if current_player == computer_mark
      human_mark
    elsif current_player == human_mark
      computer_mark
    end
  end

  def guess_some_squares(current_player, depth = 0)
    available_spaces = find_available_spaces(board)
    while depth > 0
      space = available_spaces[0]
      board[space.to_i] = current_player
      current_player = other_player(current_player)
      available_spaces = find_available_spaces(board)
      depth -= 1
    end
  end

  def simulate_and_score_outcomes(current_player, depth = 0)
    available_spaces = find_available_spaces(board)
    while depth > 0
      guess_some_squares(current_player, 1)
      check_for_win_or_block(available_spaces, current_player)
    end
  end

  def simulate_move(space, current_player)

  end

  def check_for_win_or_block(available_spaces, current_player, depth = 0)
    best_move = nil
    original_board = board.dup

    available_spaces.each do |avail_space|
      as = avail_space.to_i

      # simulate current_player in as
      board[as] = current_player 
      if someone_won # base case #1: win
        return declare_best_move_and_end_simulation(current_player, as, original_board) # win the game
      else
        board[as] = avail_space # leave alone
      end

      # simulate other_player in as
      board[as] = other_player(current_player)
      if someone_won # base case #1: win
        return declare_best_move_and_end_simulation(other_player(current_player), as, original_board) # win the game
      else
        board[as] = avail_space # leave alone
      end

    end
    return best_move
  end

  def get_best_move(board, current_player, depth = 0, best_score = {})
    # For each available space, simulate computer going there and check for a win. If a win, that's best move. If none, thereafter simulate human going to each remaining space and check for a win. If a win, preventing it is the best move.  If none, just choose a random move.
    available_spaces = find_available_spaces(board)
    best_move = check_for_win_or_block(available_spaces, current_player)
    choose_best_move_or_random_move(best_move, available_spaces)
  end

  def choose_best_move_or_random_move(best_move, available_spaces)
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def someone_won
    combinations.any? {|comb| comb.uniq.length == 1}
  end

  def set_winner
    if someone_won
      if combinations.any? {|comb| comb.uniq == [human_mark]}
        @winner = human_mark
      elsif combinations.any? {|comb| comb.uniq == [computer_mark]}        
        @winner = computer_mark
      end
    end
  end

  def tie
    board.all? { |s| s == computer_mark || s == human_mark }
  end

end

