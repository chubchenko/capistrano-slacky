# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Facade::Changelog do
  describe ".for" do
    let(:changelog) { instance_double(described_class) }

    before do
      allow(described_class).to receive(:new)
        .with(previous: "2eab27b", current: "02c4c96")
        .and_return(changelog)

      allow(changelog).to receive(:call)
    end

    it "creates a changelog instance and calls the #call method" do
      described_class.for(env: Capistrano::Configuration.env)

      expect(changelog).to have_received(:call)
    end
  end

  describe "#call" do
    subject(:changelog) { described_class.new(previous: "2eab27b", current: "02c4c96") }

    context "when the revisions diff is empty" do
      before do
        allow(Capistrano::Slacky::Command::Diff).to receive(:call)
          .with(previous: "2eab27b", current: "02c4c96")
          .and_return([])
      end

      it "returns an empty block of context" do
        expect(changelog.call.as_json).to eq(
          {
            type: :context,
            elements: [
              {
                type: :mrkdwn,
                text: "Nothing has changed since the previous release :confounded:."
              }
            ]
          }
        )
      end
    end

    context "when there are changes between revisions" do
      before do
        allow(Capistrano::Slacky::Command::Diff).to receive(:call)
          .with(previous: "2eab27b", current: "02c4c96")
          .and_return(
            [
              Class.new do
                def to_a
                  [
                    ":one:",
                    "<https://github.com/chubchenko/capistrano-slacky/commit/02c4c96|02c4c96>",
                    "Update changelog & dependency version"
                  ]
                end
              end.new
            ]
          )
      end

      it "returns the collection of the contexts" do
        expect(changelog.call.map(&:as_json)).to eq(
          [
            {
              type: :context,
              elements: [
                {
                  type: :mrkdwn, text: ":one:"
                },
                {
                  type: :mrkdwn, text: "<https://github.com/chubchenko/capistrano-slacky/commit/02c4c96|02c4c96>"
                },
                {
                  type: :mrkdwn, text: "Update changelog & dependency version"
                }
              ]
            }
          ]
        )
      end
    end
  end
end
