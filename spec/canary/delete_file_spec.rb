# frozen_string_literal: true

require "spec_helper"

RSpec.describe Canary::DeleteFile do
  let(:args) do
    {
      file_path: file_path,
      logger: logger
    }
  end

  let(:log_file_path) { File.expand_path("log.csv", tmpdir) }
  let(:logger)        { Canary::Logger.new(file_path: log_file_path) }
  let(:file_path)     { File.expand_path("file_to_delete.txt", tmpdir) }

  describe "#call" do
    subject(:result) { described_class.new(args).call }

    context "when the file exists" do
      before do
        File.open(file_path, "w+") { |f| f.write "delete me" }
      end

      it "deletes the file" do
        expect { result }
          .to change { File.exist?(file_path) }
          .from(true)
          .to(false)
      end

      it "logs the operation" do
        expect(logger).to receive(:log).with(String)

        result
      end
    end

    context "when the file does not exist" do
      it "raises an error" do
        expect { result }.to raise_error(Canary::DeleteFileError)
      end
    end
  end
end
