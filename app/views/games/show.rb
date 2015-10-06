class GameDisplay

	# INTRODUCTIONS
	def welcome_message
		puts "\n\n||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "|||||||| Welcome to my Tic Tac Toe game ||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||\n\n"
	end

	def introduce_characters(player_char, computer_char)
		puts "You will be playing as \"#{player_char}\". The computer will be playing as \"#{computer_char}\"."
	end

	def introduce_gameplay
		puts "\nTo play, please select one of the square coordinates, 1-8.\n\n"
	end

	# DISLPAY FOR GAMEPLAY
	def prompt_turn
		puts "\nPlease select your spot.\n\n"
	end

	def display_board(board)
		puts "\t\t|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n\t\t|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n\t\t|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
	end

	def display_game_over(winner = nil)
		if winner
			puts "Game Over! The winner is #{winner}"
		else
			puts "Game Over"
		end
	end

end