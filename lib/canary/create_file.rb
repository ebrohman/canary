# frozen_string_literal: true

module Canary
  class CreateFile
    attr_reader :file_path, :options, :logger

    def initialize(file_path: "", options: "w+", logger: Canary::Logger.new)
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
      @logger.log(formatted_log_line)
    end

    private

    def formatted_log_line
      full_path = File.expand_path(file_path)
      %(#{ENV['USER']},#{$PROGRAM_NAME},"canary/create_file",#{full_path},#{Process.pid})
    end
  end
end
