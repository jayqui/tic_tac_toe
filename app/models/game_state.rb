class GameState
	attr_accessor :board, :computer_mark, :human_mark

	def initialize(board = %w[0 1 2 3 4 5 6 7 8])
		@board = board
		@computer_mark = "X"
		@human_mark = "O"
	end

	def available_spaces
		board.select { |s| s != computer_mark && s != human_mark} 
	end

	def win?(piece)
		combinations.any? { |comb| comb.uniq == [piece] }
	end

	def loss?(piece)
		combinations.any? { |comb| comb.uniq == [other_piece(piece)] }
	end

	def draw?
		available_spaces.count == 0 && !win?(computer_mark) && !win?(human_mark)
	end

	def end_state?
		win?(computer_mark) || win?(human_mark) || draw?
	end

	private

	def other_piece(piece)
		piece == computer_mark ? human_mark : computer_mark
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