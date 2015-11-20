require_relative "../app/models/best_move_calculator"

describe BestMoveCalculator do

	let(:bmc) { BestMoveCalculator.new }


	context "finding spaces & game states" do
		before(:each) do
			bmc.board = %w[X O X O X O O 7 8]
		end
		describe "#available spaces" do
			it "should give available spaces" do
				expect(bmc.available_spaces).to eq(%w[7 8])
			end
		end

		describe "#prospective_game_states" do
			it "should give the prospective game states" do
				expect(bmc.prospective_game_states.map {|gs| gs.board}).to eq([
					%w[X O X O X O O X 8], 
					%w[X O X O X O O 7 X]
					])
			end
		end
	end

end