require 'securerandom'
require 'typhoeus'

module WirecardSepa
  # Usage:
  # config = WirecardSepa::Config.new(...)
  # gateway = WirecardSepa::Gateway.new(config)
  #
  # gateway.debit({ requested_amount: 12.12, .. })
  # => response
  #
  # gateway.recurring_init
  # => response
  class Gateway
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def debit(params)
      request = DirectDebit::Request.new request_params(params)
      DirectDebit::Response.new response_body_from_post(request), request: request
    end

    def recurring_init(params)
      # request = Recurring::FirstRequest.new params.merge(config)
      # Recurring::FirstResponse.new post(request)
    end

    def recurring_process(params)
      # request = Recurring::RecurringRequest.new params.merge(config)
      # Recurring::RecurringResponse.new post(request)
    end

    private

    def response_body_from_post(request)
      Typhoeus.post(
        WirecardSepa.gateway_url,
        body: request.to_xml,
        userpwd: http_auth_credentials,
      ).body
    end

    def request_params(params)
      params.merge(config.request_params).merge({
        request_id: request_id
      })
    end

    def request_id
      # From the Wirecard processing spec:
      # Type: Alphanumeric, Length: 150
      # This is the identification number of the request on the merchants side.
      # It must be unique for each request.
      # Sample Request-ID: 048b27e0-9c31-4cab-9eab-3b72b1b4d498
      SecureRandom.uuid
    end

    def http_auth_credentials
      [config.http_auth_username, config.http_auth_password].join(':')
    end
  end
end
