# frozen_string_literal: true

require "spec_helper"

RSpec.describe Canary::MakeRequest do
  subject(:make_request) { described_class.new(args) }

  let(:args) do
    {
      ssl: ssl,
      type: type,
      headers: headers,
      body: body,
      client: client,
      logger: logger
    }
  end

  let(:log_file_path) { File.expand_path("log.csv", tmpdir) }
  let(:logger)        { Canary::Logger.new(file_path: log_file_path) }
  let(:client)        { spy(Faraday) }
  let(:ssl)           { true }
  let(:type)          { :post }
  let(:headers)       { {} }
  let(:body)          { "" }
  let(:path)          { "" }
  let(:port)          { nil }
  let(:host)          { "google.com" }

  describe "#call" do
    let(:result) { make_request.call(host, path, port) }

    context "with default options" do
      it "makes a request to the host with the specified options" do
        expect(client)
          .to receive(:post)
          .with(URI("https://google.com"), "", {})

        result
      end
    end

    context "with other options" do
      let(:type)    { :get }
      let(:headers) { { "Content-Type" => "application/json" } }

      it "makes a request with the specified options", focus: true do
        expect(client)
          .to receive(:get)
          .with(URI("https://google.com"), "", headers)

        result
      end
    end

    it "logs information about the request" do
      expect(logger).to receive(:log).with(String)

      result
    end
  end
end
