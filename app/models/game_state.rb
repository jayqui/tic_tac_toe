class GameState
	attr_accessor :board, :computer_mark, :human_mark, :current_player, :successors, :score

	def initialize(args = {})
		args[:board] ? @board = args[:board] : @board = %w[X X O O 4 O O X 8]
		args[:computer_mark] ? @computer_mark = args[:computer_mark] : @computer_mark = "X"
		args[:computer_mark] ? @computer_mark = args[:computer_mark] : @computer_mark = "X"
		args[:human_mark] ? @human_mark = args[:human_mark] : @human_mark = "O"
		args[:current_player] ? @current_player = args[:current_player] : @current_player = @computer_mark
		@score = find_score
		@successors = find_successors
	end

	def find_successors(player = current_player)
		asps = available_spaces
		return [] if asps.count > 7 # limit long runtime
		return [] if end_state?
		asps.map do |as|
			possible_board = board.dup
			possible_board[as.to_i] = player
			GameState.new(board: possible_board, current_player: other_player)
		end
	end

	def find_score
		if win?(current_player)
			10
		elsif loss?(current_player)
			-10
		elsif draw?
			0
		end
	end

	def find_scores_of_successors
		successors.map do |succ| 
			if succ.current_player == self.current_player
				succ.score
			else
				succ.score * -1 if succ.score
			end
		end
	end

	def available_spaces
		board.select { |s| s != computer_mark && s != human_mark} 
	end

	def win?(player)
		combinations.any? { |comb| comb.uniq == [player] }
	end

	def loss?(player)
		combinations.any? { |comb| comb.uniq == [other_player] }
	end

	def draw?
		available_spaces.count == 0 && !win?(computer_mark) && !win?(human_mark)
	end

	def end_state?
		win?(computer_mark) || win?(human_mark) || available_spaces.count == 0
	end

	private

	def other_player
		current_player == computer_mark ? human_mark : computer_mark
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

end