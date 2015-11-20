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
				expect(bmc.prospective_game_states).to eq([
					%w[X O X O X O O X 8], 
					%w[X O X O X O O 7 X]
					])
			end
		end
	end

	describe "#win?" do
		it "should correctly identify a win" do
			bmc.board = %w[X X X O X O O 7 O]
			expect(bmc.win?("X")).to eq(true)
		end
		it "should correctly identify a non-win" do
			bmc.board = %w[X 1 X O X O O 7 O]
			expect(bmc.win?("X")).to eq(false)
		end
	end

	describe "#loss?" do
		it "should correctly idenitfy a loss" do
			bmc.board = %w[O O O 
										 X 4 X
										 X O X]
			expect(bmc.loss?("X")).to eq(true)
		end
		it "should correctly idenitfy a non-loss" do
			bmc.board = %w[O 1 O 
										 X 4 X
										 X O X]
			expect(bmc.loss?("X")).to eq(false)
		end
	end

end