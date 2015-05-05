module WirecardSepa
  # Usage:
  # WirecardSepa::Config.new({
  #   http_auth_username: 'foo',
  #   http_auth_password: 'bar',
  #   …
  # })
  # => config
  #
  # For sandbox testing the config provides a hardcoded config object
  # WirecardSepa::Config.for_sandbox
  # => config # Object with all necessary infos for sandbox testing
  class Config
    AUTH_PARAMS     = %i(http_auth_username http_auth_password)
    REQUEST_PARAMS  = %i(merchant_account_id creditor_id)
    EXPECTED_PARAMS = AUTH_PARAMS + REQUEST_PARAMS

    attr_accessor *EXPECTED_PARAMS
    attr_reader :params

    def initialize(params = {})
      if params.keys.sort != EXPECTED_PARAMS.sort
        raise Errors::InvalidParamsError.new(
          "Please provide a hash exactly with the following keys: #{EXPECTED_PARAMS}\n" +
          "Missing params: #{EXPECTED_PARAMS - params.keys}\n" +
          "Unexpected params: #{params.keys - EXPECTED_PARAMS}"
        )
      end
      @params = params
    end

    def self.for_sandbox
      new(
        http_auth_username: '70000-APITEST-AP',
        http_auth_password: 'qD2wzQ_hrc!8',
        merchant_account_id: '4c901196-eff7-411e-82a3-5ef6b6860d64',
        creditor_id: 'abcdef'
      )
    end

    def http_auth_username
      params[:http_auth_username]
    end

    def http_auth_password
      params[:http_auth_password]
    end

    def [](key)
      params[key]
    end

    def request_params
      REQUEST_PARAMS.each_with_object({}) { |key, h| h[key] = params[key] }
    end

    def to_hash
      params
    end
  end
end
