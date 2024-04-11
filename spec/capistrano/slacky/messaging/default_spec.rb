# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Messaging::Default do
  describe "#payload_for_updated" do
    let(:backend) { instance_double(SSHKit::Backend::Netssh) }

    before do
      allow(Capistrano::Slacky::On).to receive(:on).with(within: :repository).and_yield

      allow(SSHKit::Backend).to receive(:current).and_return(backend)
      allow(backend).to receive(:capture)
        .with(:git, :log, "--oneline", "--first-parent", "2eab27b..02c4c96")
        .and_return(
          "02c4c96 Update changelog & dependency version\n" \
          "705253c Build initial version of the gem (#1)\n"
        )
    end

    it "returns the Hash representation for a successful deployment" do
      expect(described_class.new(env: Capistrano::Configuration.env).payload_for_updated).to match(
        {
          blocks: [
            {
              type: :header,
              text: {
                type: :plain_text,
                text: a_string_matching(/^Deployed successfully :.+:$/),
                emoji: true
              }
            },
            {
              type: :section,
              fields: [
                {type: :mrkdwn, text: ">*Stage:*"},
                {type: :mrkdwn, text: "`production`"},
                {type: :mrkdwn, text: ">*Branch:*"},
                {type: :mrkdwn, text: "`main`"},
                {type: :mrkdwn, text: ">*Duration:*"},
                {type: :mrkdwn, text: a_string_matching(/`\d{2}:\d{2}`/)}
              ]
            },
            {
              type: :context,
              elements: [
                {
                  type: :mrkdwn,
                  text: "*Current* revision <https://github.com/chubchenko/capistrano-slacky/commit/02c4c96|02c4c96>" \
                        " - " \
                        "<https://github.com/chubchenko/capistrano-slacky/compare/2eab27b...02c4c96|compare>" \
                        " (_previous revision was " \
                        "<https://github.com/chubchenko/capistrano-slacky/commit/2eab27b|2eab27b>_)."
                }
              ]
            },
            {
              type: :context,
              elements: [
                {type: :mrkdwn, text: ":one:"},
                {type: :mrkdwn, text: "<https://github.com/chubchenko/capistrano-slacky/commit/705253c|705253c>"},
                {type: :mrkdwn, text: "Build initial version of the gem (#1)"}
              ]
            },
            {
              type: :context,
              elements: [
                {type: :mrkdwn, text: ":two:"},
                {type: :mrkdwn, text: "<https://github.com/chubchenko/capistrano-slacky/commit/02c4c96|02c4c96>"},
                {type: :mrkdwn, text: "Update changelog & dependency version"}
              ]
            },
            {
              type: :context,
              elements: [
                {type: :mrkdwn, text: ":truck: Deployed By: @chubchenko"}
              ]
            }
          ]
        }
      )
    end
  end

  describe "#payload_for_reverted" do
    it "returns the Hash representation for a successful rollback" do
      expect(described_class.new(env: Capistrano::Configuration.env).payload_for_reverted).to match(
        {
          blocks: [
            {
              type: :header,
              text: {
                type: :plain_text,
                text: a_string_matching(/^Reverted successfully :.+:$/),
                emoji: true
              }
            },
            {
              type: :section,
              fields: [
                {type: :mrkdwn, text: ">*Stage:*"},
                {type: :mrkdwn, text: "`production`"},
                {type: :mrkdwn, text: ">*Branch:*"},
                {type: :mrkdwn, text: "`main`"},
                {type: :mrkdwn, text: ">*Duration:*"},
                {type: :mrkdwn, text: a_string_matching(/`\d{2}:\d{2}`/)}
              ]
            },
            {
              type: :context,
              elements: [
                {
                  type: :mrkdwn,
                  text: "*Current* revision <https://github.com/chubchenko/capistrano-slacky/commit/02c4c96|02c4c96>" \
                        " - " \
                        "<https://github.com/chubchenko/capistrano-slacky/compare/2eab27b...02c4c96|compare>" \
                        " (_previous revision was " \
                        "<https://github.com/chubchenko/capistrano-slacky/commit/2eab27b|2eab27b>_)."
                }
              ]
            },
            {
              type: :context,
              elements: [
                {type: :mrkdwn, text: ":truck: Deployed By: @chubchenko"}
              ]
            }
          ]
        }
      )
    end
  end

  describe "#payload_for_failed" do
    let(:env) { Capistrano::Configuration.env }

    context "when deployment failed" do
      around do |example|
        env.set(:deploying, true)

        example.run

        env.set(:deploying, false)
      end

      it "returns the Hash representation for a failed deployment" do
        expect(described_class.new(env: env).payload_for_failed).to match(
          {
            blocks: [
              {
                type: :header,
                text: {
                  type: :plain_text,
                  text: a_string_matching(/Deployment failed :.+:$/),
                  emoji: true
                }
              },
              {
                type: :section,
                fields: [
                  {type: :mrkdwn, text: ">*Stage:*"},
                  {type: :mrkdwn, text: "`production`"},
                  {type: :mrkdwn, text: ">*Branch:*"},
                  {type: :mrkdwn, text: "`main`"},
                  {type: :mrkdwn, text: ">*Duration:*"},
                  {type: :mrkdwn, text: a_string_matching(/`\d{2}:\d{2}`/)}
                ]
              },
              {
                type: :context,
                elements: [
                  {type: :mrkdwn, text: "Something went wrong and we couldn't get the exception to display :sob:."}
                ]
              },
              {
                type: :context,
                elements: [
                  {type: :mrkdwn, text: ":truck: Deployed By: @chubchenko"}
                ]
              }
            ]
          }
        )
      end
    end

    context "when rollback failed" do
      it "returns the Hash representation for a failed rollback" do
        expect(described_class.new(env: env).payload_for_failed).to match(
          {
            blocks: [
              {
                type: :header,
                text: {
                  type: :plain_text,
                  text: a_string_matching(/Rollback failed :.+:$/),
                  emoji: true
                }
              },
              {
                type: :section,
                fields: [
                  {type: :mrkdwn, text: ">*Stage:*"},
                  {type: :mrkdwn, text: "`production`"},
                  {type: :mrkdwn, text: ">*Branch:*"},
                  {type: :mrkdwn, text: "`main`"},
                  {type: :mrkdwn, text: ">*Duration:*"},
                  {type: :mrkdwn, text: a_string_matching(/`\d{2}:\d{2}`/)}
                ]
              },
              {
                type: :context,
                elements: [
                  {type: :mrkdwn, text: "Something went wrong and we couldn't get the exception to display :sob:."}
                ]
              },
              {
                type: :context,
                elements: [
                  {type: :mrkdwn, text: ":truck: Deployed By: @chubchenko"}
                ]
              }
            ]
          }
        )
      end
    end
  end
end
