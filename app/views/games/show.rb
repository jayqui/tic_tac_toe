require_relative "../../../app/helpers/colorize"

class GameDisplay

	# INTRODUCTIONS
	def welcome_message
		clear_screen
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||"
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

	def ask_who_should_start
		print "Which player should move first? "
	end

	def clear_screen
		print %x{clear}
	end

	# ERROR MESSAGES
	def error_must_be_0_8
		puts "Must be one of 0-8."
	end

	def error_cant_be_0_8
		puts "Can't be 0-8."
	end

	def error_cant_be_already_taken
		puts "Can't be already taken."
	end

	def error_already_chosen(opts = {})
		hash = {"human" => "You", "computer" => "The computer"}
		puts "#{hash[opts]} already chose that spot."
	end

	def error_must_choose
		puts "You must choose a character."
	end

	def error_must_be_1_char
		puts "The symbol must be one character long."
	end

	def bad_input
		puts "Hmm... I don't understand. Try again."
	end


	# COLORATION
	def human_color(text)
		green(text)
	end

	def computer_color(text)
		red(text)
	end

	def colorize_board(board, human_mark, comp_mark)
		board.map do |square|
			if square == human_mark
				human_color(square)
			elsif square == comp_mark
				computer_color(square)
			else
				square
			end
		end
	end


	# DISLPAY FOR GAMEPLAY
	def prompt_turn
		print "\nPlease select your spot: "
	end


	def display_board(board, human_mark, comp_mark)
		b = colorize_board(board, human_mark, comp_mark)
		puts "\n\t\t|_#{b[0]}_|_#{b[1]}_|_#{b[2]}_|\n\t\t|_#{b[3]}_|_#{b[4]}_|_#{b[5]}_|\n\t\t|_#{b[6]}_|_#{b[7]}_|_#{b[8]}_|\n"
	end

	def state_computer_move(move)
		puts "The computer chose: #{move}"
	end

	def display_game_over(winner, human_won)
		puts "\n\n||||||||||||||||||||||||||||||||||||||||||||||||||"
		print "         "

		if winner && human_won
			puts "Game Over!" + human_color(" The winner is #{winner}!")
		elsif winner && !human_won
			puts "Game Over!" + computer_color(" The winner is #{winner}!")
		else
			puts yellow("\nGame Over! The result is a tie.")
		end
	
		puts "||||||||||||||||||||||||||||||||||||||||||||||||||\n\n"
	end

end