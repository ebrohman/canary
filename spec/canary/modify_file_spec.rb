# frozen_string_literal: true

require "spec_helper"

RSpec.describe Canary::ModifyFile do
  let(:args) do
    {
      file_path: file_path,
      options: "a+",
      logger: logger
    }
  end

  let(:log_file_path) { File.expand_path("log.csv", tmpdir) }
  let(:logger)        { Canary::Logger.new(file_path: log_file_path) }
  let(:file_path)     { File.expand_path("editable_file.txt", tmpdir) }

  after(:each) do
    File.delete(file_path) if File.exist?(file_path)
  end

  describe "#call" do
    subject { described_class.new(args) }

    context "when a file exists" do
      it "appends to the file" do
        file = File.open(file_path, "w+") { |f| f.write "Old content\n" }

        subject.call("New content")

        expect(File.read(file_path)).to eq "Old content\nNew content"
      end

      it "loggs data about the operation" do
        expect(logger).to receive(:log).with(String)

        subject.call("content")
      end
    end

    context "when a file does not exist" do
      it "creates the file and writes to it" do
        subject.call("New content")

        expect(File.read(file_path)).to eq "New content"
      end
    end
  end
end
