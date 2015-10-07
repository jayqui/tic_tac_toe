require_relative "../../../app/helpers/colorize"

class GameDisplay

	# INTRODUCTIONS
	def welcome_message
		print %x{clear}
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


	# DISLPAY FOR GAMEPLAY
	def prompt_turn
		print "\nPlease select your spot: "
	end

	def colorize_board(board, human_mark, comp_mark)
		board.map do |square|
			if square == human_mark
				green(square)
			elsif square == comp_mark
				red(square)
			else
				square
			end
		end
	end

	def display_board(board, human_mark, comp_mark)
		b = colorize_board(board, human_mark, comp_mark)
		puts "\n\t\t|_#{b[0]}_|_#{b[1]}_|_#{b[2]}_|\n\t\t|_#{b[3]}_|_#{b[4]}_|_#{b[5]}_|\n\t\t|_#{b[6]}_|_#{b[7]}_|_#{b[8]}_|\n"
	end

	def state_computer_move(move)
		puts "The computer chose: #{move}"
	end

	def display_game_over(winner)
		if winner
			puts "\nGame Over! The winner is #{winner}!"
		else
			puts "\nGame Over! The result is a tie."
		end
	end

end