# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Facade::Body do
  describe "#as_json" do
    subject(:body) { described_class.new(env: Capistrano::Configuration.env) }

    it "returns a Hash representation of the body block" do
      expect(body.as_json).to match(
        {
          type: :section,
          fields: [
            {
              type: :mrkdwn, text: ">*Stage:*"
            },
            {
              type: :mrkdwn, text: "`production`"
            },
            {
              type: :mrkdwn, text: ">*Branch:*"
            },
            {
              type: :mrkdwn, text: "`main`"
            },
            {
              type: :mrkdwn, text: ">*Duration:*"
            },
            {
              type: :mrkdwn, text: a_string_matching(/`\d{2}:\d{2}`/)
            }
          ]
        }
      )
    end
  end
end
