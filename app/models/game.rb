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
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @human_mark
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @computer_mark
      else
        spot = get_best_move(@board, @computer_mark)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @computer_mark
        else
          spot = nil
        end
      end
    end
  end

  def find_available_spaces
    board.select { |s| s != "X" && s != "O"}    
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    best_move = nil
    available_spaces = find_available_spaces
    
    available_spaces.each do |as|
      board[as.to_i] = @computer_mark
      if someone_won
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @human_mark
        if someone_won
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
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
    board.all? { |s| s == "X" || s == "O" }
  end

end

