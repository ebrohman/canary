# frozen_string_literal: true

require "canary/version"

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
end
