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
    EXPECTED_PARAMS = %i( http_auth_username http_auth_password
      merchant_account_name merchant_account_id creditor_id )

    attr_accessor *EXPECTED_PARAMS
    attr_reader :params

    def initialize(params = {})
      if params.keys.sort != EXPECTED_PARAMS.sort
        raise Errors::InvalidParamsError.new("Please provide a hash with exactly the following keys: #{EXPECTED_PARAMS}")
      end
      @params = params
    end

    def self.for_sandbox
      new(
        http_auth_username: '70000-APITEST-AP',
        http_auth_password: 'qD2wzQ_hrc!8',
        merchant_account_id: '4c901196-eff7-411e-82a3-5ef6b6860d64',
        merchant_account_name: 'WD SEPA Test',
        creditor_id: 'abcdef'
      )
    end

    def [](key)
      params[key]
    end

    def to_hash
      params
    end
  end
end
