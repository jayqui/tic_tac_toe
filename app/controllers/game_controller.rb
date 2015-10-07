class GameController

	attr_reader :game, :view

	def initialize
		@game = Game.new
		@view = GameDisplay.new
	end

	### controller shorthand methods ###
	def someone_won
		game.someone_won
	end

	def tie
		game.tie
	end

	def board
		game.board
	end

	def computer_mark
		game.computer_mark
	end

	def human_mark
		game.human_mark
	end

	### GAME-INITIALIZING BUSINESS ###
	def introductions
		view.welcome_message
		view.introduce_gameplay
		solicit_player_symbols
	end

	def get_human_symbol
		view.solicit_human_symbol
		h_candidate = gets.chomp
		until acceptable_mark?(h_candidate)
    	handle_bad_mark_input(h_candidate)
			view.solicit_human_symbol
			h_candidate = gets.chomp
		end
		game.human_mark = h_candidate
	end
	
	def get_computer_symbol(human_symbol)
		view.solicit_computer_symbol
		c_candidate = gets.chomp
		until acceptable_mark?(c_candidate) && c_candidate != human_symbol
			handle_bad_mark_input(c_candidate, human_symbol)
			view.solicit_computer_symbol
			c_candidate = gets.chomp
		end
		game.computer_mark = c_candidate
	end
	
	def solicit_player_symbols
		h = get_human_symbol
		get_computer_symbol(h)
	end

	### ERROR HANDLING ###
	def acceptable_mark?(candidate_mark)
		not_0_thru_8(candidate_mark) && candidate_mark.length >= 1
	end
	
	def handle_bad_mark_input(candidate, second_candidate = nil)
  	view.error_must_choose if candidate.length < 1
		view.error_cant_be_0_8 if !not_0_thru_8(candidate)
		view.error_cant_be_already_taken if second_candidate == candidate
	end
	
	def acceptable_input?(input)
		!not_0_thru_8(input) && !(board[input] == computer_mark) && !(board[input] == human_mark)
	end
	
	def handle_bad_input(input)
    if not_0_thru_8(input)
    	view.error_must_be_0_8
    	display_and_prompt
    elsif board[input] == computer_mark 
    	view.error_already_chosen("computer")
    	display_and_prompt
    elsif board[input] == human_mark
    	view.error_already_chosen("human")
    	display_and_prompt
    end
	end


	#########################################
	############ MAIN GAME LOGIC ############
	#########################################

	def get_human_move
    spot = gets.chomp.to_i
	  until acceptable_input?(spot)
	  	handle_bad_input(spot)
	    spot = gets.chomp.to_i
	  end
    board[spot] = human_mark
	end
	def display_and_prompt
		view.display_board(game.board)
		view.prompt_turn
	end

	def play_game
		introductions
		display_and_prompt

	  until someone_won || tie
	    get_human_move
	    if !someone_won && !tie
	      move = game.generate_computer_move
	      view.state_computer_move(move)
		    display_and_prompt
	    end
	  end
	  game.set_winner
	  view.display_game_over(game.winner)
	end

end