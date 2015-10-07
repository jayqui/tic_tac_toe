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
		view.introduce_characters("O","X")
		view.introduce_gameplay
	end

	def display_and_prompt
		view.display_board(game.board)
		view.prompt_turn
	end

	def play_game
		introductions
		display_and_prompt

	  until someone_won || tie
	    game.get_human_spot
	    if !someone_won && !tie
	      game.generate_computer_move
	    end
	    display_and_prompt
	  end
	  game.set_winner
	  view.display_game_over(game.winner)
	end

end