# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Block::Header do
  describe "#as_json" do
    it "returns a Hash representation of the header block" do
      expect(described_class.new("Slacky").as_json).to eq(
        {
          type: :header,
          text: {
            type: :plain_text,
            text: "Slacky",
            emoji: true
          }
        }
      )
    end
  end
end
