# frozen_string_literal: true

RSpec.describe Capistrano::Slacky do
  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:icon_emoji) }
  it { is_expected.to respond_to(:channel) }
  it { is_expected.to respond_to(:klass) }
  it { is_expected.to respond_to(:slacky?) }
  it { is_expected.to respond_to(:repo) }
  it { is_expected.to respond_to(:on) }
end
