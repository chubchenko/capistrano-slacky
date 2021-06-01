# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Configuration do
  describe "#username" do
    context "when the username absent" do
      subject(:configuration) { described_class.new }

      it "returns default username" do
        expect(configuration.username).to eq("ChatOps")
      end
    end

    context "when the username exists" do
      subject(:configuration) { described_class.new }

      around do |example|
        Capistrano::Configuration.env.set(:slacky, {username: "Slacky"})
        example.run
        Capistrano::Configuration.env.delete(:slacky)
      end

      it "returns existing username" do
        expect(configuration.username).to eq("Slacky")
      end
    end
  end

  describe "#icon_emoji" do
    context "when the icon_emoji absent" do
      subject(:configuration) { described_class.new }

      it "returns default icon_emoji" do
        expect(configuration.icon_emoji).to eq(":robot_face:")
      end
    end

    context "when the icon_emoji exists" do
      subject(:configuration) { described_class.new }

      around do |example|
        Capistrano::Configuration.env.set(:slacky, {icon_emoji: ":mask:"})
        example.run
        Capistrano::Configuration.env.delete(:slacky)
      end

      it "returns existing username" do
        expect(configuration.icon_emoji).to eq(":mask:")
      end
    end
  end

  describe "#channel" do
    context "when the channel absent" do
      subject(:configuration) { described_class.new }

      it "returns default channel" do
        expect(configuration.channel).to eq("#deployment")
      end
    end

    context "when the channel exists" do
      subject(:configuration) { described_class.new }

      around do |example|
        Capistrano::Configuration.env.set(:slacky, {channel: "#slacky"})
        example.run
        Capistrano::Configuration.env.delete(:slacky)
      end

      it "returns existing channel" do
        expect(configuration.channel).to eq("#slacky")
      end
    end
  end

  describe "#klass" do
    context "when the klass absent" do
      subject(:configuration) { described_class.new }

      it { expect(configuration.klass).to be_nil }
    end

    context "when the klass exists" do
      subject(:configuration) { described_class.new }

      around do |example|
        Capistrano::Configuration.env.set(:slacky, {klass: Capistrano::Slacky::Messaging::Base})
        example.run
        Capistrano::Configuration.env.delete(:slacky)
      end

      it "returns existing klass" do
        expect(configuration.klass).to eq(Capistrano::Slacky::Messaging::Base)
      end
    end
  end

  describe "#slacky?" do
    context "when slacky equals false" do
      subject(:configuration) { described_class.new }

      around do |example|
        Capistrano::Configuration.env.set(:slacky, false)
        example.run
        Capistrano::Configuration.env.delete(:slacky)
      end

      it { is_expected.not_to be_slacky }
    end

    context "when slacky equals true" do
      subject(:configuration) { described_class.new }

      around do |example|
        Capistrano::Configuration.env.set(:slacky, true)
        example.run
        Capistrano::Configuration.env.delete(:slacky)
      end

      it { is_expected.to be_slacky }
    end

    context "when slacky equals the empty hash" do
      subject(:configuration) { described_class.new(env: {}) }

      around do |example|
        Capistrano::Configuration.env.set(:slacky, {})
        example.run
        Capistrano::Configuration.env.delete(:slacky)
      end

      it { is_expected.to be_slacky }
    end
  end

  describe "#url" do
    subject(:configuration) { described_class.new }

    context "when the repository URL match the SSH format" do
      it "returns HTTP format of URL" do
        expect(configuration.repo.url).to eq("https://github.com/chubchenko/capistrano-slacky")
      end
    end

    context "when the repository URL match the HTTP format" do
      around do |example|
        Capistrano::Configuration.env.set(:repo_url, "https://github.com/chubchenko/capistrano-slacky")
        example.run
        Capistrano::Configuration.env.set(:repo_url, "git@github.com:chubchenko/capistrano-slacky.git")
      end

      it "returns original URL" do
        expect(configuration.repo.url).to eq("https://github.com/chubchenko/capistrano-slacky")
      end
    end
  end
end
