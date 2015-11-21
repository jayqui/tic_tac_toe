require_relative "../app/models/game_state"

describe "GameState" do

	let(:gs) { GameState.new }
	let(:draw) { GameState.new(board: %w[O X O 
									 										 X O X
																			 X O X]) }
	let(:win)  { GameState.new(board: gs.board = %w[X X X O X O O 7 O]) }
	let(:loss) { GameState.new(board: %w[O O O 
																		 	 X 4 X
																			 X O X]) }

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

	describe "#draw?" do
		it "should correctly idenitfy a draw" do
			expect(draw.draw?).to eq(true)
		end
		it "should identify a win as a non-draw" do
			gs.board = %w[O X O 
									 	X X X
										O O X]
			expect(gs.draw?).to eq(false)
		end
		it "should identify a win as a non-draw" do
			gs.board = %w[O O O 
									 	X O X
										X O X]
			expect(gs.draw?).to eq(false)
		end
	end

	describe "#available_spaces" do

		before(:each) do
			gs.board = %w[X X O 
										O 4 O 
									  O X 8]
		end

		it "can find available spaces" do
			expect(gs.available_spaces).to eq(%w[4 8])
		end
	end

	describe "#find_successors" do
		# see `find_successors_spec.rb`
	end
	

		# TESTING TIME TO EXECUTION
		# context "board with five openings" do
		# 	it "has five successors" do
		# 		gs = GameState.new(board: %w[X O X O 4 5 6 7 8])
		# 		expect(gs.find_successors.count).to eq(5)
		# 	end
		# end
		# context "board with six openings" do
		# 	it "has six successors" do
		# 		gs = GameState.new(board: %w[X O X 3 4 5 6 7 8])
		# 		expect(gs.find_successors.count).to eq(6)
		# 	end
		# end
		context "board with seven openings" do
			it "has seven successors" do
				gs = GameState.new(board: %w[0 X 2 3 O 5 6 7 8])
				expect(gs.find_successors.count).to eq(7)
			end
		end
		# context "board with eight openings" do
		# 	it "has eight successors" do
		# 		gs = GameState.new(board: %w[X 1 2 3 4 5 6 7 8])
		# 		expect(gs.find_successors).to eq([])
		# 	end
		# end
		# context "empty board" do
		# 	it "has nine successors" do
		# 		gs = GameState.new(board: %w[0 1 2 3 4 5 6 7 8])
		# 		expect(gs.find_successors).to eq([])
		# 	end
		# end

end