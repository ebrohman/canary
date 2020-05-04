# frozen_string_literal: true

require "byebug"
require "faraday"

module Canary
  class MakeRequestError < Error; end

  class MakeRequest
    attr_reader :ssl, :type, :headers, :body
    attr_accessor :client, :logger

    def initialize(ssl: true, type: :post, headers: {}, body: nil, client: Faraday, logger: Canary::Logger.new)
      @ssl = ssl
      @type = type
      @headers = headers
      @body = body
      @client = client
      @logger = logger
    end

    def call(host, path = "", port = 80)
      @address = form_uri(host, path, port.to_i)
      client.send(type.to_sym, @address, body, headers)
      logger.log(log_line)
    end

    private

    def form_uri(host, path, port)
      if ssl
        @port = 443
        URI::HTTPS.build(host: host, path: path)
      else
        @port = port
        URI::HTTP.build(host: host, path: path, port: port.to_i)
      end
    end

    def local_address
      Socket.ip_address_list.detect(&:ipv4_private?)&.ip_address || Socket.gethostname
    end

    def log_line
      body_size = body&.bytesize || 0
      protocol = ssl ? "https" : "http"

      "#{ENV['USER']},#{$PROGRAM_NAME},canary/make_request,#{type},#{@address}:#{@port},#{local_address},#{body_size},#{protocol},#{Process.pid}"
    end
  end
end
