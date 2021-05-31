# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Runner do
  describe ".call" do
    let(:env) { Capistrano::Configuration.env }
    let(:payload) { instance_double(Capistrano::Slacky::Payload) }

    before do
      allow(Capistrano::Slacky::Payload).to receive(:new).with(
        env: env, action: :updated
      ).and_return(payload)
    end

    context "when the payload does not empty" do
      before do
        allow(payload).to receive(:empty?).and_return(false)
        allow(Capistrano::Slacky::Fanout).to receive(:call).with(
          payload: payload
        )
      end

      it "executes fanout" do
        described_class.call(env: env, action: :updated)

        expect(Capistrano::Slacky::Fanout).to have_received(:call).with(
          payload: payload
        )
      end
    end

    context "when the payload empty" do
      before do
        allow(payload).to receive(:empty?).and_return(true)
        allow(Capistrano::Slacky::Fanout).to receive(:call)
      end

      it "skips execution of fanout" do
        described_class.call(env: env, action: :updated)

        expect(Capistrano::Slacky::Fanout).not_to have_received(:call)
      end
    end
  end
end
