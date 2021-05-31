# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Payload do
  describe "#empty?" do
    subject(:payload) { described_class.new(env: Capistrano::Configuration.env, action: :updated) }

    before do
      allow(Capistrano::Slacky::Messaging).to receive(:for)
        .with(env: Capistrano::Configuration.env)
        .and_return(messaging)
    end

    context "when the payload for the action empty" do
      let(:messaging) { instance_double(Capistrano::Slacky::Messaging::Null) }

      before do
        allow(messaging).to receive(:payload_for).with(action: :updated).and_return(nil)
      end

      it { is_expected.to be_empty }
    end

    context "when the payload for the action is not empty" do
      let(:messaging) { instance_double(Capistrano::Slacky::Messaging::Default) }

      before do
        allow(messaging).to receive(:payload_for).with(action: :updated).and_return({
          blocks: [
            {
              type: :context,
              elements: [
                {type: :mrkdwn, text: "Slacky"}
              ]
            }
          ]
        })
      end

      it { is_expected.not_to be_empty }
    end
  end

  describe "#to_json" do
    subject(:payload) { described_class.new(env: Capistrano::Configuration.env, action: :updated) }

    let(:messaging) { instance_double(Capistrano::Slacky::Messaging::Default) }

    before do
      allow(Capistrano::Slacky::Messaging).to receive(:for)
        .with(env: Capistrano::Configuration.env)
        .and_return(messaging)

      allow(messaging).to receive(:payload_for).with(action: :updated).and_return({
        blocks: [
          {
            type: :context,
            elements: [
              {type: :mrkdwn, text: "Slacky"}
            ]
          }
        ]
      })
    end

    it "returns a JSON representation of the payload" do
      expect(payload.to_json).to eq(
        {
          username: "ChatOps",
          icon_emoji: ":robot_face:",
          channel: "#deployment",
          blocks: [
            {
              type: :context,
              elements: [
                {type: :mrkdwn, text: "Slacky"}
              ]
            }
          ]
        }.to_json
      )
    end
  end
end
