# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Block::Section do
  describe "#as_json" do
    it "returns a Hash representation of the section block" do
      expect(described_class.new("Capistrano", "Slacky").as_json).to eq(
        {
          type: :section,
          fields: [
            {
              type: :mrkdwn,
              text: "Capistrano"
            },
            {
              type: :mrkdwn,
              text: "Slacky"
            }
          ]
        }
      )
    end
  end
end
