# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Block::Root do
  describe "#as_json" do
    let(:block) do
      Capistrano::Slacky::Block::Context.new("Slacky")
    end

    it "returns a Hash representation of the root block" do
      expect(described_class.new(block).as_json).to eq(
        blocks: [
          {
            type: :context,
            elements: [
              {
                type: :mrkdwn,
                text: "Slacky"
              }
            ]
          }
        ]
      )
    end
  end
end
