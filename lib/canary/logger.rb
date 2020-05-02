# frozen_string_literal: true

require "logger" # ruby logger

module Canary
  class Logger
    def initialize(file_path: ENV.fetch("LOG_FILE", File.join(Canary.root, "log/telemetry.csv")))
      @file   = File.open(file_path, "a+")
      @logger = ::Logger.new(@file)
      @logger.formatter = proc do |_severity, datetime, _progname, msg|
        "#{datetime},#{msg}\n"
      end
    end

    def log(msg)
      @logger.info(msg)
      @file.close
    end
  end
end
