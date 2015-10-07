require "rspec"
require_relative "../app/models/game"
require_relative "../app/views/games/show"
require_relative "../app/helpers/helpers"
require_relative "../app/controllers/game_controller"

describe "GameController" do
	let(:gc) { GameController.new }

	describe "#not_0_thru_8" do
		it "returns false for '8'" do
			expect(not_0_thru_8('8')).to eq(false)
		end
		it "returns true for '9'" do
			expect(not_0_thru_8('9')).to eq(true)
		end
	end
	
	describe "#acceptable_mark?" do
		it "should reject '8'" do
			expect(gc.acceptable_mark?('8')).to eq(false)
		end
		it "should allow '9'" do
			expect(gc.acceptable_mark?('9')).to eq(true)
		end
		it "should not allow empty string" do
			expect(gc.acceptable_mark?("")).to eq(false)
		end
	end

	describe "#acceptable_input?" do
		it "should allow '8'" do
			expect(gc.acceptable_input?('8')).to eq(true)
		end
		it "should reject '9'" do
			expect(gc.acceptable_input?('9')).to eq(false)
		end
		it "should reject 'asdf'" do
			expect(gc.acceptable_input?('asdf')).to eq(false)
		end
		it "doesn't allow taking a space occupied by the human" do
			gc.game.board[8] = gc.game.human_mark
			expect(gc.acceptable_input?('8')).to eq(false)
		end
		it "doesn't allow taking a space occupied by the computer" do
			gc.game.board[0] = gc.game.computer_mark
			expect(gc.acceptable_input?('0')).to eq(false)
		end

	end

end
