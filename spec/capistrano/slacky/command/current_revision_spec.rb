# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Command::CurrentRevision do
  describe ".call" do
    let(:backend) { instance_double(SSHKit::Backend::Netssh) }

    before do
      allow(Capistrano::Slacky::On).to receive(:on)
        .with(within: :release)
        .and_yield

      allow(SSHKit::Backend).to receive(:current).and_return(backend)

      allow(backend).to receive(:capture)
        .with(:cat, "REVISION")
        .and_return("2eab27")
    end

    it "returns current revision" do
      expect(described_class.call).to eq("2eab27")
    end
  end
end
