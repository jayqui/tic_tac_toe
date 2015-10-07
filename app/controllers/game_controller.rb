class GameController

	attr_reader :game, :view

	def initialize
		@game = Game.new
		@view = GameDisplay.new
	end

	def someone_won
		game.someone_won
	end

	def tie
		game.tie
	end

	def introductions
		view.welcome_message
		view.introduce_gameplay
		solicit_player_symbols
	end

	def solicit_player_symbols
		# get human symbol
		view.solicit_human_symbol
		h_candidate = gets.chomp
		until !('0'..'8').include?(h_candidate)
			view.error_1_8
			view.solicit_human_symbol
			h_candidate = gets.chomp
		end
		game.human_mark = h_candidate

		# get computer symbol
		view.solicit_computer_symbol
		c_candidate = gets.chomp
		until c_candidate != h_candidate && !('0'..'8').include?(c_candidate)
			view.error_1_8_already_taken
			view.solicit_computer_symbol
			c_candidate = gets.chomp
		end
		game.computer_mark = c_candidate
	end

	def display_and_prompt
		view.display_board(game.board)
		view.prompt_turn
	end

	def get_human_move
	  spot = nil
	  until spot
	    spot = gets.chomp.to_i
	    if @board[spot] == computer_mark && @board[spot] != human_mark
	      @board[spot] = @human_mark
	    else
	      spot = nil
	    end
	  end
	end

	def play_game
		introductions
		display_and_prompt

	  until someone_won || tie
	    game.get_human_spot
	    if !someone_won && !tie
	      move = game.generate_computer_move
	      view.state_computer_move(move)
	    end
	    display_and_prompt
	  end
	  game.set_winner
	  view.display_game_over(game.winner)
	end

end