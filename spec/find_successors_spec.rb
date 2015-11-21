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
			it "a *correct* tree" do
				expect(gs.successors.last.successors.first.board).to eq(
						%w[X X O 
							 O O O 
							 O X X])
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

		context "one more example" do
			before(:each) do
				gs.board = %w[X O O 
											3 4 O 
										  6 X 8]
			end

			it "the board should have 4 immediate successors" do
				expect(gs.find_successors.count).to eq(4)
			end
			it "with the correct boards" do
				expect(gs.find_successors.map{|s| s.board}).to eq([
					%w[X O O 
						 X 4 O 
					   6 X 8],
					%w[X O O 
						 3 X O 
					   6 X 8],
					%w[X O O 
						 3 4 O 
					   X X 8],
					%w[X O O 
						 3 4 O 
					   6 X X],
					])
			end
			it "these set up a move for O" do
				expect(gs.find_successors[0].successors.map{|s|s.board}).to eq([
					%w[X O O 
						 X O O 
					   6 X 8],
					%w[X O O 
						 X 4 O 
					   O X 8],
					%w[X O O 
						 X 4 O 
					   6 X O],
		    ])
			end
			it "which in last case is a win for O" do
				expect(gs.find_successors[0].successors[2].win?("O")).to eq(true)
			end
			it "which has no successors" do
				expect(gs.find_successors[0].successors[2].successors).to eq([])
			end
			it "again, if X blocks, then it's O's turn" do
				expect(gs.find_successors[3].successors.map{|s|s.board}).to eq([
					%w[X O O 
						 O 4 O 
					   6 X X],
					%w[X O O 
						 3 O O 
					   6 X X],
					%w[X O O 
						 3 4 O 
					   O X X],
				])
			end
			it "after which it's X's turn" do
				expect(gs.find_successors[3].successors[2].successors.map{|s|s.board}).to eq([
					%w[X O O 
						 X 4 O 
					   O X X],
					%w[X O O 
						 3 X O 
					   O X X],
				])
			end
			it "after which it's O's turn" do
				expect(gs.find_successors[3].successors[2].successors[0].successors.map{|s|s.board}).to eq([
					%w[X O O 
						 X O O 
					   O X X],
				])
			end
		end

	end
end