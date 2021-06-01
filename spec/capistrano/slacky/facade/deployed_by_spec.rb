# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Facade::DeployedBy do
  describe "#as_json" do
    subject(:deployed_by) { described_class.new(env: Capistrano::Configuration.env) }

    it "returns a Hash representation of the deployed by block" do
      expect(deployed_by.as_json).to eq(
        {
          type: :context,
          elements: [
            {
              type: :mrkdwn, text: ":truck: Deployed By: @chubchenko"
            }
          ]
        }
      )
    end
  end
end
