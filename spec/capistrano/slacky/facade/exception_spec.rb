# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Facade::Exception do
  describe "#as_json" do
    context "when the exception is absent" do
      subject(:exception) { described_class.new(exception: nil) }

      it "returns a Hash representation of the exception block" do
        expect(exception.as_json).to eq(
          {
            type: :context,
            elements: [
              {
                type: :mrkdwn, text: "Something went wrong and we couldn't get the exception to display :sob:."
              }
            ]
          }
        )
      end
    end

    context "when the exception exists" do
      subject(:exception) { described_class.new(exception: ex) }

      let(:ex) { StandardError.new("Oups") }

      it "returns a Hash representation of the exception block" do
        expect(exception.as_json).to eq(
          {
            type: :context,
            elements: [
              {
                type: :mrkdwn, text: "Oups"
              }
            ]
          }
        )
      end
    end
  end
end
