require_relative "../app/models/game_state"

describe "GameState" do

	let(:gs) { GameState.new }

	describe "#win?" do
		it "should correctly identify a win" do
			gs.board = %w[X X X O X O O 7 O]
			expect(gs.win?("X")).to eq(true)
		end
		it "should correctly identify a non-win" do
			gs.board = %w[X 1 X O X O O 7 O]
			expect(gs.win?("X")).to eq(false)
		end
	end

	describe "#loss?" do
		it "should correctly idenitfy a loss" do
			gs.board = %w[O O O 
									 	X 4 X
										X O X]
			expect(gs.loss?("X")).to eq(true)
		end
		it "should correctly idenitfy a non-loss" do
			gs.board = %w[O 1 O 
										 X 4 X
										 X O X]
			expect(gs.loss?("X")).to eq(false)
		end
	end

end