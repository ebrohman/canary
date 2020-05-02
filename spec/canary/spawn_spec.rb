# frozen_string_literal: true

require "spec_helper"

RSpec.describe Canary::Spawn do
  describe ".call" do
    subject(:result) { described_class.call(args) }

    let(:args) do
      {
        file_path: file_path,
        options: options
      }
    end

    let(:options) { [] }

    context "when the file exists" do
      context "when the file is a bash script do" do
        let(:file_path) { File.expand_path("../fixtures/test_spawn", File.dirname(__FILE__)) }

        it "starts the process" do
          expect { result }.to output("A bash script \n").to_stdout_from_any_process
        end

        it "returns the pid" do
          expect(result).to be_a(Integer)
        end

        context "when passed extra args" do
          let(:options) { ["foo", "bar"] }

          it "starts the process with those args" do
            expect { result }.to output("A bash script foo bar\n").to_stdout_from_any_process
          end
        end
      end

      context "when the file is a ruby script" do
        let(:file_path) { File.expand_path("../fixtures/test_spawn.rb", File.dirname(__FILE__)) }

        it "starts the process" do
          expect { result }.to output("I spawned a Ruby process \n").to_stdout_from_any_process
        end

        it "returns the pid" do
          expect(result).to be_a(Integer)
        end

        context "when passed extra args" do
          let(:options) { ["foo", "bar" ] }

          it "starts the process with those args" do
            expect { result }.to output("I spawned a Ruby process foo bar\n").to_stdout_from_any_process
          end
        end
      end
    end

    context "when the file does not exist" do
      let(:file_path) { "/not/a/real/file" }

      it "raises an error" do
        expect { result }.to raise_error(Canary::SpawnError)
      end
    end
  end
end
