# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Facade::Revision do
  describe "#as_json" do
    subject(:revision) { described_class.new(env: Capistrano::Configuration.env) }

    it "returns a Hash representation of the revision block" do
      expect(revision.as_json).to eq(
        {
          type: :context,
          elements: [
            {
              type: :mrkdwn,
              text: "*Current* revision <https://github.com/chubchenko/capistrano-slacky/commit/02c4c96|02c4c96>" \
                    " - " \
                    "<https://github.com/chubchenko/capistrano-slacky/compare/2eab27b...02c4c96|compare>" \
                    " (" \
                    "_previous revision was <https://github.com/chubchenko/capistrano-slacky/commit/2eab27b|2eab27b>_" \
                    ")."
            }
          ]
        }
      )
    end
  end
end
