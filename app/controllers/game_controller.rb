class GameController

	attr_reader :game, :view

	def initialize
		@game = Game.new
		@view = GameDisplay.new
	end

	def game_is_over
		game.game_is_over(game.board)
	end

	def tie
		game.tie(game.board)
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

	  until game_is_over || tie
	    game.get_human_spot
	    if !game_is_over && !tie
	      game.eval_board
	    end
	    view.display_board(game.board)
	  end
	  view.display_game_over(winner)
	end

end