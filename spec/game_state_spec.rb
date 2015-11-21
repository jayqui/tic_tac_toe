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

	# gs = GameState.new(board: %w[X X O 
	# 												     O 4 O 
	# 												     O X 8])
	# p "gs.inspect: #{gs.inspect}"
	

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

		context "board with two immediate successors" do
			before(:each) do
				gs.board = %w[X X O 
											O 4 O 
										  O X 8]
			end

			it "should return an array" do
				expect(gs.find_successors).to be_a(Array)
			end
			it "of the possible game states" do
				expect(gs.find_successors[0]).to be_a(GameState)
			end
			it "with the correct boards" do
				expect(gs.find_successors.map{|s| s.board}).to eq([
					%w[X X O 
						 O X O 
						 O X 8],
					%w[X X O 
						 O 4 O 
						 O X X]
					])
			end
			it "should yield a tree" do
				expect(gs.successors.last.successors.first).to be_a(GameState)
			end
			it "that terminates at end states" do
				expect(gs.successors.first.successors).to eq([])
			end
		end

		context "boards that are end states" do
			it "draw board's successors are empty array" do
				expect(draw.find_successors).to eq []
			end
			it "winning board's successors are empty array" do
				expect(win.find_successors).to eq []
			end
			it "losing board's successors are empty array" do
				expect(loss.find_successors).to eq []
			end

		end
	end

end