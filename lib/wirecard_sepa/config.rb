module WirecardSepa
  # Usage:
  # WirecardSepa::Config.new({
  #   api_url: 'https://api-test.wirecard.com/engine/rest/paymentmethods',
  #   http_auth_username: 'foo',
  #   http_auth_password: 'bar',
  #   merchant_account_id: '123',
  #   credit_id: '987',
  # })
  # => config
  class Config
    attr_reader :api_url, :http_auth_username, :http_auth_password, :merchant_account_id, :creditor_id

    def initialize(api_url:, http_auth_username:, http_auth_password:, merchant_account_id:, creditor_id:)
      @api_url = api_url
      @http_auth_username = http_auth_username
      @http_auth_password = http_auth_password
      @merchant_account_id = merchant_account_id
      @creditor_id = creditor_id
    end
  end
end
