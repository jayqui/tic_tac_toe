require_relative "app/helpers/helpers"
require_relative "app/controllers/game_controller"
require_relative "app/models/game"
require_relative "app/views/games/show"

controller = GameController.new
controller.play_game