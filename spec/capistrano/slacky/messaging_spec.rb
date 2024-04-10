# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Messaging do
  describe ".for" do
    let(:env) { Capistrano::Configuration.env }

    context "when slacky is disabled" do
      before do
        allow(Capistrano::Slacky).to receive(:slacky?).and_return(false)

        allow(Capistrano::Slacky::Messaging::Null).to receive(:new).with(env: env)

        described_class.for(env: env)
      end

      it "returns the null messaging instance" do
        expect(Capistrano::Slacky::Messaging::Null).to have_received(:new).with(
          env: env
        )
      end
    end

    context "when there is a messaging class" do
      before do
        allow(Capistrano::Slacky).to receive_messages(slacky?: true, klass: Capistrano::Slacky::Messaging::Base)

        allow(Capistrano::Slacky::Messaging::Base).to receive(:new).with(env: env)

        described_class.for(env: env)
      end

      it "returns the custom messaging instance" do
        expect(Capistrano::Slacky::Messaging::Base).to have_received(:new).with(
          env: env
        )
      end
    end

    context "when there is a messaging class is absent" do
      before do
        allow(Capistrano::Slacky).to receive_messages(slacky?: true, klass: nil)

        allow(Capistrano::Slacky::Messaging::Default).to receive(:new).with(env: env)

        described_class.for(env: env)
      end

      it "returns the default messaging instance" do
        expect(Capistrano::Slacky::Messaging::Default).to have_received(:new).with(
          env: env
        )
      end
    end
  end
end
