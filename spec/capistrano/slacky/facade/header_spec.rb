# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Facade::Header do
  describe "#as_json" do
    subject(:header) { described_class.new(:deployed_successfully) }

    before do
      stub_const(
        "Capistrano::Slacky::Facade::Header::EMOJI_MAP",
        deployed_successfully: [":drooling_face:"]
      )
    end

    it "returns a Hash representation of the header block" do
      expect(header.as_json).to eq(
        {
          type: :header,
          text: {
            type: :plain_text,
            text: "Deployed successfully :drooling_face:",
            emoji: true
          }
        }
      )
    end
  end
end
