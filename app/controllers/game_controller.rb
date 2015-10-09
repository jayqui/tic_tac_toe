class GameController

	attr_reader :game, :view

	def initialize
		@game = Game.new
		@view = GameDisplay.new
	end

	### controller shorthand methods ###
	def someone_won		; game.someone_won	; end
	def tie						; game.tie					; end
	def board 				; game.board				; end
	def computer_mark	; game.computer_mark; end
	def human_mark		; game.human_mark		; end

	### GAME-INITIALIZING BUSINESS ###
	def introductions
		view.welcome_message
		view.introduce_gameplay
		solicit_player_symbols
		assign_starting_player
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

	def ask_who_should_start
		view.ask_who_should_start
		gets.chomp
	end

	def interpret_starting_player(who)
		if who == computer_mark
			@starting_player = computer_mark
		elsif who == human_mark
			@starting_player = human_mark
		end
	end

	def assign_starting_player
		who = ask_who_should_start
		interpret_starting_player(who)
		until who == computer_mark || who == human_mark
			view.bad_input
			who = ask_who_should_start
			interpret_starting_player(who)
		end
	end

	### ERROR HANDLING ###
	def acceptable_mark?(candidate_mark)
		not_0_thru_8(candidate_mark) && candidate_mark.length == 1
	end
	
	def handle_bad_mark_input(candidate, second_candidate = nil)
  	view.error_must_choose if candidate.length < 1
  	view.error_must_be_1_char if candidate.length > 1
		view.error_cant_be_0_8 if !not_0_thru_8(candidate)
		view.error_cant_be_already_taken if second_candidate == candidate
	end
	
	def acceptable_input?(input)
		int = input.to_i
		!not_0_thru_8(input) && !(board[int] == computer_mark) && !(board[int] == human_mark)
	end
	
	def handle_bad_input(num_string)
		num = num_string.to_i
    if not_0_thru_8(num_string)
    	view.error_must_be_0_8
    	display_and_prompt
    elsif board[num] == computer_mark 
    	view.error_already_chosen("computer")
    	display_and_prompt
    elsif board[num] == human_mark
    	view.error_already_chosen("human")
    	display_and_prompt
    end
	end

	def handle_unclear_starting_player

	end


	#########################################
	############ MAIN GAME LOGIC ############
	#########################################

	def get_human_move
    spot = gets.chomp
	  until acceptable_input?(spot)
	  	handle_bad_input(spot)
	    spot = gets.chomp
	  end
	  num = spot.to_i
    board[num] = human_mark
	end

	def display_and_prompt
		view.display_board(game.board, human_mark, computer_mark)
		view.prompt_turn
	end

	def generate_and_report_computer_move
		move = game.generate_computer_move
		view.state_computer_move(move)
	end

	def play_game
		introductions
		view.clear_screen

		if @starting_player == computer_mark
			generate_and_report_computer_move
		end

	  until someone_won || tie
			display_and_prompt
	    get_human_move
	    if !someone_won && !tie
	    	generate_and_report_computer_move
	    end
	  end
	  game.set_winner
		view.display_board(game.board, human_mark, computer_mark)
	  
	  view.display_game_over(game.winner, game.winner == human_mark)
	end

end