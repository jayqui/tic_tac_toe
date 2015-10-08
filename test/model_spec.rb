require "rspec"
require_relative "../app/models/game"

describe "Game" do
	let (:g) { Game.new }

	describe "#find_available_spaces" do
		it "should find the available spaces" do
			g.board = ["X", "X", "X", "3", "4", "5", "6", "7", "8"]
			expect(g.find_available_spaces(g.board)).to eq(%w[3 4 5 6 7 8])
		end
	end

	describe "#generate_computer_move" do
		it "should choose the center if the center is open (on the first move)" do
			g.board = ["O", "1", "2", "3", "4", "5", "6", "7", "8"]
			expect(g.generate_computer_move).to eq(4)
		end
	end

	describe "#get_best_move" do
		it "should find win if possible (above)" do
			g.board = ["0", "1", "2", "X", "4", "5", "X", "7", "8"]
			expect(g.get_best_move(g.board, g.computer_mark)).to eq({0 => 100})
		end
		it "should find win if possible (interior)" do
			g.board = ["0", "1", "X", "3", "4", "5", "6", "7", "X"]
			expect(g.get_best_move(g.board, g.computer_mark)).to eq({5 => 100})
		end
		it "should find win if possible (below)" do
			g.board = ["0", "X", "2", "3", "X", "5", "6", "7", "8"]
			expect(g.get_best_move(g.board, g.computer_mark)).to eq({7 => 100})
		end
		it "should find human win threat if present (above)" do
			g.board = ["0", "1", "2", "O", "4", "5", "O", "7", "8"]
			expect(g.get_best_move(g.board, g.computer_mark)).to eq({0 => -100})
		end
		it "should find human win threat if present (interior)" do
			g.board = ["0", "1", "O", "3", "4", "5", "6", "7", "O"]
			expect(g.get_best_move(g.board, g.computer_mark)).to eq({5 => -100})
		end
		it "should find human win threat if present (below)" do
			g.board = ["0", "O", "2", "3", "O", "5", "6", "7", "8"]
			expect(g.get_best_move(g.board, g.computer_mark)).to eq({7 => -100})
		end
	end

	describe "#guess_some_squares" do
		it "should guess one square" do
			g.board = ["X", "O", "2", "3", "O", "5", "6", "7", "8"]
			g.guess_some_squares(g.computer_mark, 1)
			expect(g.board).to eq(["X", "O", "X", "3", "O", "5", "6", "7", "8"])
		end
		it "should guess a second square" do
			g.board = ["X", "O", "2", "3", "O", "5", "6", "7", "8"]
			g.guess_some_squares(g.computer_mark, 2)
			expect(g.board).to eq(["X", "O", "X", "O", "O", "5", "6", "7", "8"])
		end
		it "should guess a third square" do
			g.board = ["X", "O", "2", "3", "O", "5", "6", "7", "8"]
			g.guess_some_squares(g.computer_mark, 3)
			expect(g.board).to eq(["X", "O", "X", "O", "O", "X", "6", "7", "8"])
		end
	end

	describe "#choose_best_move_or_random_move" do
		it "should return the best move if one has been found" do
			best_move = 5
			available_spaces = [0,1,2,3,5,6,7,8]
			expect(g.choose_best_move_or_random_move(best_move, available_spaces)).to eq(5)
		end
		it "should return a random move if a best move has not been found" do
			srand(0)
			best_move = nil
			available_spaces = [0,1,2,3,5,6,7,8]
			expect(g.choose_best_move_or_random_move(best_move, available_spaces)).to eq(6)
		end
	end

	describe "#someone_won" do
		it "should return false if no one has won" do
			expect(g.someone_won).to eq(false)
		end		
		it "should return true if someone has won" do
			g.board = ["O", "O", "O", "3", "4", "5", "6", "7", "8"]
			expect(g.someone_won).to eq(true)
		end
	end

	describe "#set_winner" do
		it "should set the human as the winner if the human has won" do
			g.board = ["O", "O", "O", "3", "4", "5", "6", "7", "8"]
			expect(g.set_winner).to eq(g.human_mark)
		end
		it "should set the computer as the winner if the computer has won" do
			g.board = ["X", "X", "X", "3", "4", "5", "6", "7", "8"]
			expect(g.set_winner).to eq(g.computer_mark)
		end
		it "should not set a winner even if the board is full" do
			g.board = ["O", "X", "O", "X", "O", "O", "X", "O", "X"]
			expect(g.set_winner).to eq(nil)
		end
	end

end