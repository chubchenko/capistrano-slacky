# frozen_string_literal: true

RSpec.describe "slacky", type: :task do
  describe "updated" do
    it "slacky after a successful deployment" do
      allow(Capistrano::Slacky::Runner).to receive(:call)

      Rake::Task["slacky:updated"].invoke

      expect(Capistrano::Slacky::Runner).to have_received(:call).with(
        action: :updated
      )
    end

    it "invokes slacky:updated after deploy:finishing" do
      allow(Rake::Task["slacky:updated"]).to receive(:invoke)

      Rake::Task["deploy:finishing"].execute

      expect(Rake::Task["slacky:updated"]).to have_received(:invoke)
    end
  end

  describe "reverted" do
    before { allow(Capistrano::Slacky::Command::CurrentRevision).to receive(:call) }

    it "slacky after successful rollback" do
      allow(Capistrano::Slacky::Runner).to receive(:call)

      Rake::Task["slacky:reverted"].invoke

      expect(Capistrano::Slacky::Runner).to have_received(:call).with(
        action: :reverted
      )
    end

    it "invokes slacky:reverted after deploy:finishing_rollback" do
      allow(Rake::Task["slacky:reverted"]).to receive(:invoke)

      Rake::Task["deploy:finishing_rollback"].execute

      expect(Rake::Task["slacky:reverted"]).to have_received(:invoke)
    end

    it "invokes slacky:ensure_current_revision before slacky:reverted" do
      expect(Rake::Task["slacky:reverted"].prerequisites).to match_array("ensure_current_revision")
    end
  end

  describe "failed" do
    before do
      allow(Capistrano::Slacky::Runner).to receive(:call)
    end

    it "Slacky after failure deployment or rollback" do
      Rake::Task["slacky:failed"].invoke

      expect(Capistrano::Slacky::Runner).to have_received(:call).with(
        action: :failed
      )
    end

    it "invokes slacky:failed after deploy:failed" do
      allow(Rake::Task["slacky:failed"]).to receive(:invoke)

      Rake::Task["deploy:failed"].execute

      expect(Rake::Task["slacky:failed"]).to have_received(:invoke)
    end
  end

  describe "ping" do
    it "pings all available tasks" do
      allow(Capistrano::Slacky::Runner).to receive(:call)

      Rake::Task["slacky:ping"].invoke

      expect(Capistrano::Slacky::Runner).to have_received(:call).exactly(3).times
    end
  end

  describe "ensure_current_revision" do
    context "when :current_revision is empty" do
      before { allow(Capistrano::Slacky::Command::CurrentRevision).to receive(:call).and_return("2eab27b") }

      around do |example|
        previous = Capistrano::Configuration.env.delete(:current_revision)
        example.run
        Capistrano::Configuration.env.set(:current_revision, previous)
      end

      it "sets :current_revision" do
        Rake::Task["slacky:ensure_current_revision"].execute

        expect(Capistrano::Configuration.env.fetch(:current_revision)).to eq("2eab27b")
      end
    end

    context "when :current_revision is not empty" do
      it "does not set :current_revision" do
        Rake::Task["slacky:ensure_current_revision"].execute

        expect(Capistrano::Configuration.env.fetch(:current_revision)).to eq("02c4c96")
      end
    end
  end
end
