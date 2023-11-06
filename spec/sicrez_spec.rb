# frozen_string_literal: true

require "active_support"
require "active_support/encrypted_configuration"
require "config"

Config.load_and_set_settings("spec/fixtures/settings.yml")

ENV["master_key"] = "5187043871509283e5e288dff641e355"

class Rails
  def self.application
    Hashie::Mash.new(
      credentials: ActiveSupport::EncryptedConfiguration.new(
        config_path: "spec/fixtures/credentials.yml.enc",
        key_path: "spec/fixtures/credentials.key",
        env_key: "master_key",
        raise_if_missing_key: true
      )
    )
  end
end

RSpec.describe Sicrez do
  it "has a version number" do
    expect(Sicrez::VERSION).not_to be nil
  end

  it "returns Rails credentials" do
    expect(Sicrez.secret_text).to eq "Sicrez is awesome"
    expect(Sicrez.nested.very_nested.secret_text).to eq "Sicrez is awesome"
  end

  it "returns Settings" do
    expect(Sicrez.settings_secret_text).to eq "Sicrez is awesome"
    expect(Sicrez.settings.very_nested.secret_text).to eq "Sicrez is awesome"
  end

  it "returns Settings" do
    ENV["env_secret_text"] = "Sicrez is awesome"
    expect(Sicrez.env_secret_text).to eq "Sicrez is awesome"
  end
end
