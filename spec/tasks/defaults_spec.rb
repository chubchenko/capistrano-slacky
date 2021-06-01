# frozen_string_literal: true

RSpec.describe "load:defaults" do
  it "adds the file to the linked files" do
    expect do
      Rake::Task["load:defaults"].invoke
    end.to change { Capistrano::Configuration.env.fetch(:linked_files) }.to(["config/slacky.yml"])
  end
end
