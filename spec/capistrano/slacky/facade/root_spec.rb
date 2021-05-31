# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Facade::Root do
  describe "#as_json" do
    subject(:root) { described_class.new(block) }

    let(:block) do
      Capistrano::Slacky::Facade::DeployedBy.new(env: Capistrano::Configuration.env)
    end

    it "returns a Hash representation of the root block" do
      expect(described_class.new(block).as_json).to eq(
        blocks: [
          {
            type: :context,
            elements: [
              {
                type: :mrkdwn, text: ":truck: Deployed By: @chubchenko"
              }
            ]
          }
        ]
      )
    end
  end
end
