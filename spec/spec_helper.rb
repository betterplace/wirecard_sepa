require 'simplecov'
require 'byebug'
require 'webmock'

include WebMock::API

WebMock.enable!

def read_support_file(file_path)
  File.open File.expand_path("../support/#{file_path}", __FILE__), "r:UTF-8", &:read
end

# Always return success xml for gateway specs.
# This could be more sophisticated, but does the job for now.
stub_request(:post, 'https://api-test.wirecard.com/engine/rest/paymentmethods/').
  to_return(status: 200, body: read_support_file('direct_debit/success/response.xml'), headers: {})

def sandbox_gateway_config
  WirecardSepa::Config.new({
    api_url:             'https://api-test.wirecard.com/engine/rest/paymentmethods/',
    http_auth_username:  '70000-APITEST-AP',
    http_auth_password:  'qD2wzQ_hrc!8',
    merchant_account_id: '4c901196-eff7-411e-82a3-5ef6b6860d64',
    creditor_id:         'DE98ZZZ09999999999',
  })
end

require 'wirecard_sepa'
