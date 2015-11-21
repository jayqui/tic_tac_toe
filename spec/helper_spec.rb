require_relative "../app/helpers/helpers"

describe "#not_0_thru_8" do
	it "returns false for '8'" do
		expect(not_0_thru_8('8')).to eq(false)
	end
	it "returns true for '9'" do
		expect(not_0_thru_8('9')).to eq(true)
	end
end