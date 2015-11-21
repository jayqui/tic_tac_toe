require_relative "game_state"

class BestMoveCalculator
	attr_accessor :board, :computer_mark, :human_mark, :current_player

	def initialize(current_player = nil, board = %w[0 1 2 3 4 5 6 7 8])
		@board = board
		@computer_mark = "X"
		@human_mark = "O"
		@current_player = current_player
		@current_player ||= @computer_mark
	end

	def available_spaces
		board.select { |s| s != computer_mark && s != human_mark} 
	end

	def prospective_next_board(player = current_player, the_board = board)
		available_spaces.map do |as|
			possible_board = board.dup
			possible_board[as.to_i] = player
			GameState.new(board: possible_board)
		end
	end

	def rate_prospective_game_states
		prospective_next_board.map do |game_state|
			if game_state.win?(current_player)
				10
			elsif game_state.loss?(current_player)
				-10
			elsif game_state.draw?
				0
			end
		end
	end

	def outcomes_table
		prospective_next_board.zip(rate_prospective_game_states).to_h
	end

	def game_over?
		outcomes_table.values.uniq != [nil]
	end

	def rate_outcomes
		return outcomes_table if game_over?



	end


	private

	def other_player
		current_player == computer_mark ? human_mark : computer_mark
	end

end