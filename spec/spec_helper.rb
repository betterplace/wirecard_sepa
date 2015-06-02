require 'simplecov'
require 'byebug'

# FIXME
# SimpleCov.adapters.define 'gem' do
#   add_filter '/spec/'
#   add_filter '/autotest/'
#   add_group 'Libraries', '/lib/'
# end
# SimpleCov.start 'gem'
def read_support_file(file_path)
  File.open File.expand_path("../support/#{file_path}", __FILE__), "r:UTF-8", &:read
end

def sandbox_gateway_config
  WirecardSepa::Config.new({
    api_url:             'https://api-test.wirecard.com/engine/rest/paymentmethods/',
    http_auth_username:  '70000-APITEST-AP',
    http_auth_password:  'qD2wzQ_hrc!8',
    merchant_account_id: '4c901196-eff7-411e-82a3-5ef6b6860d64',
    creditor_id:         'DE00000000000000000000',
  })
end

require 'wirecard_sepa'
