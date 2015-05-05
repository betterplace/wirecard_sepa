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
      request = DirectDebit::Request.new params.merge(config)
      DirectDebit::Response.new post(request)
    end

    def recurring_init(params)
      # request = Recurring::FirstRequest.new params.merge(config)
      # Recurring::FirstResponse.new post(request)
    end

    def recurring_process(params)
      # request = Recurring::RecurringRequest.new params.merge(config)
      # Recurring::RecurringResponse.new post(request)
    end

    def post(request)
      Typhoeus.post(
        WirecardSepa.gateway_url,
        body: request.to_xml,
        userpwd: http_auth_credentials,
      )
    end

    private

    def http_auth_credentials
      [config.http_auth_username, config.http_auth_password].join(':')
    end
  end
end
