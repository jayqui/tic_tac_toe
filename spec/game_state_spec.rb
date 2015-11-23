require_relative "../app/models/game_state"

describe "GameState" do

	let(:gs) { GameState.new }
	let(:g3)  { GameState.new(board: %w[O X O 
																			3 O X 
									  									X O X]) }
	let(:g48) { GameState.new(board: %w[X X O 
																			O 4 O 
									  									O X 8]) }
	let(:g346)  { GameState.new(board: %w[O X O 
																				3 4 X 
										  									6 O X])}
	let(:g3468) { GameState.new(board: %w[X O O 
																				3 4 O 
										  									6 X 8])}
	let(:g23568) { GameState.new(board: %w[O O 2 
																				 3 X 5 
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
		context "it should give negative scores where appropriate" do
			x = GameState.new(board: %w[O 1 O
																	X X O
																	X 7 8])
			it "here are the successor boards of this game state" do
				expect(x.successors.map{|s|s.board}).to eq([
					%w[O X O
						 X X O
						 X 7 8],
					%w[O 1 O
						 X X O
						 X X 8],
					%w[O 1 O
						 X X O
						 X 7 X],
					])
			end
			it "here are the second order successors, for the first tree branch" do
				expect(x.successors.first.successors.map{|s|s.board}).to eq([
					%w[O X O
						 X X O
						 X O 8],
					%w[O X O
						 X X O
						 X 7 O],
					])
			end
			it "gives negative scores where appropriate" do
			expect(x.successors.first.find_scores_of_successors).to eq([nil,-10])
			end
		end
	end

	describe "#inherit_score_from_successors" do
		it "g3 accurately inherits scores from successors" do
			g3.inherit_score_from_successors
			expect(g3.score).to eq(0)
		end
		it "g48 accurately inherits scores from successors" do
			g48.inherit_score_from_successors
			puts "g48: #{g48.inspect}"
			expect(g48.score).to eq(-10)
		end
		it "g346 accurately inherits scores from successors" do
			g346.inherit_score_from_successors
			puts "g346: #{g346.inspect}"
			expect(g346.score).to eq(0)
		end
		it "g3468 accurately inherits scores from successors" do
			g3468.inherit_score_from_successors
			expect(g3468.score).to eq(-10)
		end
		it "g23568 accurately inherits scores from successors" do
			g23568.inherit_score_from_successors
			expect(g23568.score).to eq(0)
		end

		it "g3 chooses the right successor game state" do
			g3.inherit_score_from_successors
			expect(g3.choice).to be_a(GameState)
		end
		it "g48 chooses the right successor game state" do
			g48.inherit_score_from_successors
			expect(g48.choice).to be_a(GameState)
		end
		it "g346 chooses the right successor game state" do
			g346.inherit_score_from_successors
			expect(g346.choice).to be_a(GameState)
		end
		it "g3468 chooses the right successor game state" do
			g3468.inherit_score_from_successors
			expect(g3468.choice).to be_a(GameState)
		end
		it "g23568 chooses the right successor game state" do
			g23568.inherit_score_from_successors
			expect(g23568.choice).to be_a(GameState)
		end

		it "g3 chooses the right move" do
			g3.inherit_score_from_successors
			expect(g3.choice_square).to eq(%w[3])
		end
		it "g48 chooses the right move" do
			g48.inherit_score_from_successors
			expect(g48.choice_square).to eq(%w[8])
		end
		it "g346 chooses the right move" do
			g346.inherit_score_from_successors
			expect(g346.choice_square).to eq("any")
		end
		it "g3468 chooses the right move" do
			g3468.inherit_score_from_successors
			expect(g3468.choice_square).to eq("8 sorta but it doesn't matter")
		end
		it "g23568 chooses the right move" do
			g23568.inherit_score_from_successors
			expect(g23568.choice_square).to eq(%w[2])
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
