# frozen_string_literal: true

require "canary/version"

module Canary
  class Error < StandardError; end

  autoload :Spawn, "canary/spawn"
end
