class GameState
	attr_accessor :board, :computer_mark, :human_mark, :current_player, :successors, :score

	def initialize(args = {})
		args[:board] ? @board = args[:board] : @board = %w[X X O O 4 O O X 8]
		args[:computer_mark] ? @computer_mark = args[:computer_mark] : @computer_mark = "X"
		args[:computer_mark] ? @computer_mark = args[:computer_mark] : @computer_mark = "X"
		args[:human_mark] ? @human_mark = args[:human_mark] : @human_mark = "O"
		args[:current_player] ? @current_player = args[:current_player] : @current_player = @computer_mark
		@score = nil
		@successors = find_successors
	end

	def find_successors(player = current_player)
		return [] if end_state?
		available_spaces.map do |as|
			possible_board = board.dup
			possible_board[as.to_i] = player
			GameState.new(board: possible_board)
		end
	end

	def successors_tree

	end

	def available_spaces
		board.select { |s| s != computer_mark && s != human_mark} 
	end

	def win?(piece)
		combinations.any? { |comb| comb.uniq == [piece] }
	end

	def loss?(piece)
		combinations.any? { |comb| comb.uniq == [other_piece(piece)] }
	end

	def draw?
		available_spaces.count == 0 && !win?(computer_mark) && !win?(human_mark)
	end

	def end_state?
		win?(computer_mark) || win?(human_mark) || draw?
	end

	private

	def other_piece(piece)
		piece == computer_mark ? human_mark : computer_mark
	end

	def combinations
	  [ [board[0], board[1], board[2]],
	    [board[3], board[4], board[5]],
	    [board[6], board[7], board[8]],
	    [board[0], board[3], board[6]],
	    [board[1], board[4], board[7]],
	    [board[2], board[5], board[8]],
	    [board[0], board[4], board[8]],
	    [board[2], board[4], board[6]] ]
	end

end