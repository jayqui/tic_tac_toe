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

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != computer_mark && @board[spot] != human_mark
        @board[spot] = @human_mark
      else
        spot = nil
      end
    end
  end

  def generate_computer_move
    spot = nil

    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @computer_mark
      else
        spot = get_best_move(@board, @computer_mark)
        if @board[spot] != computer_mark && @board[spot] != human_mark
          @board[spot] = @computer_mark
        else
          spot = nil
        end
      end
    end
    return spot
  end

  def find_available_spaces
    board.select { |s| s != computer_mark && s != human_mark}    
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = find_available_spaces

    best_move = nil
    # for each available space, simulate computer going there and check for a win. If a win, that's best move. If none, thereafter simulate human going to each remaining space and check for a win. If a win, preventing it is the best move.  If none, just choose a random move.
    available_spaces.each do |avail_space|
      board[avail_space.to_i] = @computer_mark
      if someone_won
        best_move = avail_space.to_i
        board[avail_space.to_i] = avail_space # put back after simluating
        return best_move
      else
        board[avail_space.to_i] = @human_mark
        if someone_won
          best_move = avail_space.to_i
          board[avail_space.to_i] = avail_space # put back after simluating
          return best_move
        else
          board[avail_space.to_i] = avail_space # leave alone
        end
      end

    end

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

