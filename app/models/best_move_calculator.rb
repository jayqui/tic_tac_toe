require_relative "game_state"

class BestMoveCalculator
	attr_accessor :board, :computer_mark, :human_mark

	def initialize(board = %w[0 1 2 3 4 5 6 7 8])
		@board = board
		@computer_mark = "X"
		@human_mark = "O"
	end

	def available_spaces
		board.select { |s| s != computer_mark && s != human_mark} 
	end

	def prospective_game_states
		available_spaces.map do |as|
			possible_board = board.dup
			possible_board[as.to_i] = "X"
			GameState.new(possible_board)
		end
	end

	def rate_prospective_game_states

	end	

end