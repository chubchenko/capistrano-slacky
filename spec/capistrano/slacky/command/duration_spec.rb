# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Command::Duration do
  describe ".call" do
    it "returns the process duration time" do
      expect(described_class.call).to match(/^\d{2}:\d{2}$/)
    end
  end
end
