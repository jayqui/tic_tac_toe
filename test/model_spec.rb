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
end