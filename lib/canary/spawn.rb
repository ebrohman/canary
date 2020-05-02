# frozen_string_literal: true

module Canary
  class SpawnError < Error; end

  class Spawn
    def self.call(file_path: "", options: [])
      file = File.expand_path(file_path)

      if File.exist?(file)
        pid = Process.spawn(file, *options)
        Process.wait(pid)
        pid
      else
        raise Canary::SpawnError, "The file does not exist - #{file_path}"
      end
    end

    def log_operation
      @logger.log(formatted_log_line)
    end

    private

    def formatted_log_line
      %(#{ENV['USER']},#{$PROGRAM_NAME},"canary/spawn",#{@file},#{@pid})
    end
  end
end
