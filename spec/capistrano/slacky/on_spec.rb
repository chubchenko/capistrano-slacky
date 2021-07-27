# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::On do
  describe ".on" do
    let(:backend) { instance_double(SSHKit::Backend::Netssh) }

    before do
      Capistrano::Configuration.env.server("example.com", roles: %w[app], primary: true)

      allow(Capistrano::DSL).to receive(:on)
        .with(Capistrano::Configuration.env.primary(:app))
        .and_yield
    end

    context "when the within the repository" do
      before do
        allow(SSHKit::Backend).to receive(:current).and_return(backend)

        allow(backend).to receive(:within).with(Pathname.new("var/www/slacky/repo"))
          .and_yield
      end

      it "yields on the remote server in the `var/www/slacky/repo` folder" do
        expect do |block|
          described_class.on(within: :repository, &block)
        end.to yield_control
      end
    end

    context "when the within the shared" do
      before do
        allow(SSHKit::Backend).to receive(:current).and_return(backend)

        allow(backend).to receive(:within).with(Pathname.new("var/www/slacky/shared"))
          .and_yield
      end

      it "yields on the remote server in the `var/www/slacky/shared` folder" do
        expect do |block|
          described_class.on(within: :shared, &block)
        end.to yield_control
      end
    end

    context "when the within the release" do
      before do
        allow(SSHKit::Backend).to receive(:current).and_return(backend)

        allow(backend).to receive(:within).with(Pathname.new("var/www/slacky/current"))
          .and_yield
      end

      it "yields on the remote server in the `var/www/slacky/current` folder" do
        expect do |block|
          described_class.on(within: :release, &block)
        end.to yield_control
      end
    end
  end
end
