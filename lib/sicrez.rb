# frozen_string_literal: true

require_relative "sicrez/version"

require "hashie"

module Sicrez
  def self.method_missing(name, *args)
    ENV[name.to_s] || # Sicrez.SEMATEXT_ID
      ENV[name.to_s.upcase] || # Sicrez.sematext_id
      ENV.send(:[], args.first.to_s) || # Sicrez['SEMATEXT_ID']
      ENV.send(:[], args.first.to_s.upcase) || # Sicrez[:sematext_id]
      rails_credentials.send(name, *args) ||
      Settings.send(name, *args)
  end

  def self.configs
    {
      env: ENV,
      rails_credentials:,
      settings: Settings.to_h
    }
  end

  def self.fetch(name, fallback = nil)
    send(name).then { |value| value.nil? ? fallback : value }
  rescue StandardError
    fallback
  end

  def self.rails_credentials
    if defined?(Rails)
      @@rails_credentials ||= Hashie::Mash.new(Rails.application.credentials.config)
    end
  end
end
