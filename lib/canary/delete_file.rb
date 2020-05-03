# frozen_string_literal: true

module Canary
  class DeleteFileError < Error; end

  class DeleteFile
    attr_reader :file_path
    attr_accessor :logger

    def initialize(file_path: "", logger: Canary::Logger.new)
      @file_path = file_path
      @logger = logger
    end

    def call
      raise Canary::DeleteFileError unless File.exist?(file_path)

      File.delete(file_path)
      log_operation
    end

    def log_operation
      logger.log(formatted_log_line)
    end

    private

    def formatted_log_line
      full_path = File.expand_path(file_path)
      %(#{ENV['USER']},#{$PROGRAM_NAME},"canary/delete_file",#{full_path},#{Process.pid})
    end
  end
end
