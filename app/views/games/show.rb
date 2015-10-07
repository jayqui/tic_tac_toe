class GameDisplay

	# INTRODUCTIONS
	def welcome_message
		puts "\n\n||||||||||||||||||||||||||||||||||||||||||||||||||"
		puts "|||||||| Welcome to my Tic Tac Toe game ||||||||||"
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||\n\n"
	end

	def introduce_gameplay
		puts "\nTo play, please select one of the square coordinates, 1-8.\n\n"
	end

	def solicit_human_symbol
		print "Enter the symbol you want to represent the human: "
	end

	def solicit_computer_symbol
		print "Enter the symbol you want to represent the computer: "
	end

	def error_1_8
		puts "Can't be 1-8."
	end

	def error_1_8_already_taken
		puts "Can't be 1-8 or already taken."
	end

	# DISLPAY FOR GAMEPLAY
	def prompt_turn
		print "\nPlease select your spot: "
	end

	def display_board(board)
		puts "\n\t\t|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n\t\t|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n\t\t|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
	end

	def state_computer_move(move)
		puts "The computer chose: #{move}"
	end

	def display_game_over(winner)
		if winner
			puts "Game Over! The winner is #{winner}!"
		else
			puts "Game Over! The result is a tie."
		end
	end

end