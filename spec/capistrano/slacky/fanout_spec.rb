# frozen_string_literal: true

RSpec.describe Capistrano::Slacky::Fanout do
  describe ".call" do
    let(:backend) { instance_double(SSHKit::Backend::Netssh) }
    let(:payload) do
      {username: "ChatOps", text: "Hello, Slacky!"}
    end

    before do
      allow(Capistrano::Slacky::On).to receive(:on)
        .with(within: :shared)
        .and_yield

      allow(SSHKit::Backend).to receive(:current).and_return(backend)
      allow(backend).to receive(:capture).with(:cat, "config/slacky.yml").and_return(
        "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
      )

      allow(Net::HTTP).to receive(:post_form)
    end

    it "makes an HTTP POST request" do
      described_class.call(payload: payload)

      expect(Net::HTTP).to have_received(:post_form).with(
        URI("https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"),
        payload: "{\"username\":\"ChatOps\",\"text\":\"Hello, Slacky!\"}"
      )
    end
  end
end
