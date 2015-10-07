require "rspec"
require_relative "../app/models/game"

describe "Game" do
	let (:g) { Game.new }
	
	describe "#get_human_spot" do

		it "should put a human spot in the board" do
			g.get_human_spot
			# g.stub!(:gets).and_return("3")
			# g.stub(:get_human_spot).and_return("3")
			# expect(g.board).to eq(["0", "1", "2", "O", "4", "5", "6", "7", "8"])
			expect(g.board).to eq(["O", "1", "2", "3", "4", "5", "6", "7", "8"])
		end

	end

	describe "#find_available_spaces" do
		it "should find the available spaces" do
			g.board = ["X", "X", "X", "3", "4", "5", "6", "7", "8"]
			expect(g.find_available_spaces).to eq(%w[3 4 5 6 7 8])
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

	describe "set_winner" do
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