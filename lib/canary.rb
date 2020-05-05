# frozen_string_literal: true

require "canary/version"
require "thor"
require "json"

module Canary
  class Error < StandardError; end

  autoload :CreateFile, "canary/create_file"
  autoload :DeleteFile, "canary/delete_file"
  autoload :MakeRequest, "canary/make_request"
  autoload :ModifyFile, "canary/modify_file"
  autoload :Spawn, "canary/spawn"
  autoload :Logger, "canary/logger"

  def self.root
    File.dirname __dir__
  end

  class Runner < Thor
    desc "create", "create a new file"
    method_option :file_path, required: true, aliases: "-f"
    method_option :data, aliases: "-d"
    method_option :file_mode, default: "w+"

    def create
      Canary::CreateFile
        .new(file_path: options.file_path,
             options: options.file_mode)
        .call(options.data)
    end

    desc "modify", "modify an existing file"
    method_option :file_path, required: true, aliases: "-f"
    method_option :data, aliases: "-d"
    method_option :file_mode, default: "a+"

    def modify
      Canary::ModifyFile
        .new(file_path: options.file_path,
             options: options.file_mode)
        .call(options.data)
    end

    desc "delete", "delete an existing file"
    method_option :file_path, required: true, aliases: "-f"

    def delete
      Canary::DeleteFile
        .new(file_path: options.file_path)
        .call
    end

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

    desc "spawn", "run an executable in a subprocess"
    method_option :file_path, required: true, aliases: "-f"
    method_option :options, default: nil

    def spawn
      Canary::Spawn
        .new(file_path: options.file_path,
             options: options.options)
        .call
    end
  end
end
