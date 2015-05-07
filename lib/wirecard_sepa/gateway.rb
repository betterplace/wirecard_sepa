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
      request_params = params.merge({
        merchant_account_id: config.merchant_account_id,
        creditor_id: config.creditor_id,
        request_id: request_id,
      })
      request_xml = DirectDebit::Request.new(request_params).to_xml
      DirectDebit::Response.for_request post(request_xml)
    end

    def recurring_init(params)
      request_params = params.merge({
        merchant_account_id: config.merchant_account_id,
        creditor_id: config.creditor_id,
        request_id: request_id,
      })
      request_xml = Recurring::FirstRequest.new(request_params).to_xml
      Recurring::FirstResponse.for_request post(request_xml)
    end

    def recurring_process(params)
      request_params = params.merge({
        merchant_account_id: config.merchant_account_id,
        request_id: request_id,
      })
      request_xml = Recurring::RecurringRequest.new(request_params).to_xml
      Recurring::RecurringResponse.for_request post(request_xml)
    end

    private

    def post(request_xml)
      Typhoeus.post(
        config.api_url,
        body: request_xml,
        userpwd: http_auth_credentials,
      )
    end

    def request_id
      # From the Wirecard processing spec:
      # Type: Alphanumeric, Length: 150
      # This is the identification number of the request on the merchants side.
      # It must be unique for each request.
      # Sample Request-ID: 048b27e0-9c31-4cab-9eab-3b72b1b4d498
      # SecureRandom.uuid
      # SecureRandom.uuid
      (SecureRandom.random_number * 10**15).to_i
    end

    def http_auth_credentials
      [config.http_auth_username, config.http_auth_password].join(':')
    end
  end
end
