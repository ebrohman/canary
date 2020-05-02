# frozen_string_literal: true

module Canary
  class ModifyFile
    attr_reader :file_path, :options
    attr_accessor :logger

    def initialize(file_path: "", options: "a+", logger: Canary::Logger.new)
      @file_path = file_path
      @options   = options
      @logger    = logger
    end

    def call(data)
      File.open(file_path, options) do |f|
        f.write(data)
      end

      log_operation
    end

    def log_operation
      logger.log(formatted_log_line)
    end

    private

    def formatted_log_line
      full_path = File.expand_path(file_path)
      %(#{ENV['USER']},#{$PROGRAM_NAME},"canary/modify_file",#{full_path},#{Process.pid})
    end
  end
end
