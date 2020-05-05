# frozen_string_literal: true

require "bundler/setup"
require "canary"
require "byebug"
require "json"

class Network < Thor
  desc "request", "make a network request"
  method_option :ssl, default: nil
  method_option :type, default: "get"
  method_option :headers, default: "{}"
  method_option :body, default: nil
  method_option :host, required: true
  method_option :path, default: ""
  method_option :port, default: "80"

  allow_incompatible_default_type!

  def request
    Canary::MakeRequest
      .new(ssl: options.ssl,
           type: options.type,
           headers: JSON.parse(options.headers),
           body: options.body)
      .call(options.host, options.path, options.port)
  end
end
