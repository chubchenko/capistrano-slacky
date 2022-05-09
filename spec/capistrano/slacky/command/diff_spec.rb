# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Command::Diff do
  describe ".call" do
    let(:diff) { instance_double(described_class) }

    before do
      allow(Capistrano::Slacky::On).to receive(:on)
        .with(within: :repository)
        .and_yield

      allow(diff).to receive(:call)

      allow(described_class).to receive(:new)
        .with(previous: "2eab27", current: "02c4c96")
        .and_return(diff)
    end

    it "creates a diff instance and calls the #call method" do
      described_class.call(previous: "2eab27", current: "02c4c96")

      expect(diff).to have_received(:call)
    end
  end

  describe "#call" do
    let(:backend) { instance_double(SSHKit::Backend::Netssh) }

    before do
      allow(SSHKit::Backend).to receive(:current).and_return(backend)

      allow(backend).to receive(:capture)
        .with(:git, :log, "--oneline", "--first-parent", "2eab27..02c4c96")
        .and_return(
          "02c4c96 Update changelog & dependency version\n" \
          "705253c Build initial version of the gem\n" \
          "837d7a1 Merge pull request #4502 from chubchenko/dependabot/bundler/rspec-4.0.1\n"
        )

      allow(backend).to receive(:capture)
        .with(:git, :log, "-1", "837d7a1", '--pretty=format:"%b"')
        .and_return("Bump rspec from 3.7.1 to 4.0.1\n")
    end

    it "returns a collection of messages where each element responds to the #to_a method" do
      expect(described_class.new(previous: "2eab27", current: "02c4c96").call.map(&:to_a)).to match_array(
        [
          [
            ":one:",
            "<https://github.com/chubchenko/capistrano-slacky/commit/837d7a1|837d7a1>",
            "Bump rspec from 3.7.1 to 4.0.1"
          ],
          [
            ":two:",
            "<https://github.com/chubchenko/capistrano-slacky/commit/705253c|705253c>",
            "Build initial version of the gem"
          ],
          [
            ":three:",
            "<https://github.com/chubchenko/capistrano-slacky/commit/02c4c96|02c4c96>",
            "Update changelog & dependency version"
          ]
        ]
      )
    end
  end
end
