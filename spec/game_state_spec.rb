require_relative "../app/models/game_state"

describe "GameState" do

	let(:gs) { GameState.new }
	let(:g48) { GameState.new(board: %w[X X O 
																			O 4 O 
									  									O X 8]) }
	let(:g3468) { GameState.new(board: %w[X O O 
																				3 4 O 
										  									6 X 8])}
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
			expect(loss.loss?("X")).to eq(true)
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
		it "no matter which player has won" do
			gs.board = %w[O O O 
									 	X O X
										X O X]
			expect(gs.draw?).to eq(false)
		end
	end

	describe "#available_spaces" do
		it "can find available spaces" do
			expect(g48.available_spaces).to eq(%w[4 8])
		end
	end

	describe "#find_successors" do
		# see `find_successors_spec.rb`
	end

	describe "#find_score" do
		it "should return 10 for a win" do
			expect(win.score).to eq(10)
		end
		it "should return -10 for a loss" do
			expect(loss.score).to eq(-10)
		end
		it "should return 0 for a draw" do
			expect(draw.score).to eq(0)
		end
		it "should return nil for a non-end-state" do
			gs.board = %w[X X O 
										O 4 O 
									  O X 8]
			expect(gs.score).to eq(nil)
		end
	end
	
	describe "#find_scores_of_successors" do
		it "should find the sucessors' scores for g48" do
			expect(g48.find_scores_of_successors).to eq([10,nil])
		end
		it "should find the sucessors' scores for g3468" do
			expect(g3468.find_scores_of_successors).to eq([nil,nil,nil,nil])
		end
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
		xcontext "board with seven openings" do
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
