# frozen_string_literal: true

require "spec_helper"

RSpec.describe Canary::CreateFile do
  let(:args) do
    {
      file_path: file_path,
      options: "w+",
      logger: logger
    }
  end

  let(:file_path)     { File.expand_path("created_file.txt", tmpdir) }
  let(:log_file_path) { File.expand_path("log.csv", tmpdir) }
  let(:logger)        { Canary::Logger.new(file_path: log_file_path) }
  let(:data) { "A string of data" }

  around do |ex|
    File.delete(file_path) if File.exist?(file_path)
    ex.run
    File.delete(file_path) if File.exist?(file_path)
  end

  describe ".call" do
    subject(:result) { described_class.new(args).call(data) }

    context "when given a file path and data" do
      it "creates a new file in the given location" do
        expect { result }
          .to change { File.exist?(file_path) }
          .from(false)
          .to(true)
      end

      it "writes the data to the file" do
        result

        expect(File.read(file_path)).to eq "A string of data"
      end

      it "loggs data about the operation" do
        expect(logger).to receive(:log).with(String)

        result
      end
    end
  end
end
