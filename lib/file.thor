# frozen_string_literal: true

require "bundler/setup"
require "canary"

class File < Thor
  desc "create", "create a new file"
  method_option :file_path, required: true, aliases: "-f"
  method_option :data, default: "new data"
  method_option :file_mode, default: "w+"

  def create
    Canary::CreateFile
      .new(file_path: options.file_path,
           options: options.file_mode)
      .call(options.data)
  end

  desc "modify", "modify an existing file"
  method_option :file_path, required: true, aliases: "-f"
  method_option :data, default: "appended data"
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
end
