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
end
