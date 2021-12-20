# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Messaging::Null do
  describe "#payload_for" do
    let(:null) { described_class.new(env: Capistrano::Configuration.env) }

    context "when action is `updated`" do
      before do
        allow(null).to receive(:public_send).with("payload_for_updated")

        null.payload_for(action: :updated)
      end

      it { expect(null).to have_received(:public_send).with("payload_for_updated") }
    end

    context "when action is `reverted`" do
      before do
        allow(null).to receive(:public_send).with("payload_for_reverted")

        null.payload_for(action: :reverted)
      end

      it { expect(null).to have_received(:public_send).with("payload_for_reverted") }
    end

    context "when action is `failed`" do
      before do
        allow(null).to receive(:public_send).with("payload_for_failed")

        null.payload_for(action: :failed)
      end

      it { expect(null).to have_received(:public_send).with("payload_for_failed") }
    end

    context "when the action is unpermitted" do
      it "raises an exception that action is unpermitted" do
        expect do
          null.payload_for(action: :unpermitted)
        end.to raise_error(
          Capistrano::Slacky::Messaging::UnpermittedAction,
          "Unpermitted action: unpermitted."
        )
      end
    end
  end

  describe "#payload_for_updated" do
    subject(:null) { described_class.new(env: Capistrano::Configuration.env) }

    it { expect(null.payload_for_updated).to be_nil }
  end

  describe "#payload_for_reverted" do
    subject(:null) { described_class.new(env: Capistrano::Configuration.env) }

    it { expect(null.payload_for_reverted).to be_nil }
  end

  describe "#payload_for_failed" do
    subject(:null) { described_class.new(env: Capistrano::Configuration.env) }

    it { expect(null.payload_for_failed).to be_nil }
  end
end
