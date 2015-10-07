require "rspec"
require_relative "../app/models/game"

# let (:plain_board) { ["0", "1", "2", "3", "4", "5", "6", "7", "8"] }
# let (:o_board) { ["O", "1", "2", "O", "4", "5", "O", "7", "8"] }

describe "Game" do
	
	# let (:human_choice) { 3 }
	# let (:g) { Game.new }
	
	describe "#get_human_spot" do
		# let (:plain_board) { ["0", "1", "2", "3", "4", "5", "6", "7", "8"] }
		it "should put a human spot in the board" do
			g = Game.new
			g.stub!(:gets).and_return("3")
			g.get_human_spot
			expect(g.board).to eq(["0", "1", "2", "O", "4", "5", "6", "7", "8"])
		end

	end
end