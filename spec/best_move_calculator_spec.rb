require_relative "../app/models/best_move_calculator"

describe BestMoveCalculator do

	let(:bmc) { BestMoveCalculator.new }


	context "finding spaces & game states" do
		before(:each) do
			bmc.board = %w[X X O 
										 O 4 O 
										 O X 8]
		end
		describe "#available spaces" do
			it "should give available spaces" do
				expect(bmc.available_spaces).to eq(%w[4 8])
			end
		end

		describe "#prospective_next_board" do
			it "should give the prospective game states" do
				expect(bmc.prospective_next_board
				.map {|gs| gs.board}
				).to eq([
					%w[X X O 
						 O X O 
						 O X 8], 
					%w[X X O 
						 O 4 O 
						 O X X]
					])
			end

			it "also works with O supplied" do
					expect(bmc.prospective_next_board("O")
					.map {|gs| gs.board}
					).to eq([
					%w[X X O 
						 O O O 
						 O X 8],
				  %w[X X O 
					 	 O 4 O 
					 	 O X O]
					])
			end
		end

		describe "#rate_prospective_game_states" do
			it "should rate the prospective game states" do
				expect(bmc.rate_prospective_game_states).to eq([10,0])
			end
		end

	end

end