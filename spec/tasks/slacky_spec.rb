# frozen_string_literal: true

RSpec.describe "slacky:updated" do
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

RSpec.describe "slacky:reverted" do
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
end

RSpec.describe "slacky:failed" do
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

RSpec.describe "slacky:ping" do
  it "pings all available tasks" do
    allow(Capistrano::Slacky::Runner).to receive(:call)

    Rake::Task["slacky:ping"].invoke

    expect(Capistrano::Slacky::Runner).to have_received(:call).exactly(3).times
  end
end
