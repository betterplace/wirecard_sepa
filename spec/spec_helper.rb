require 'simplecov'
require 'byebug'
require 'vcr'

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

VCR.configure do |config|
  cache_timeout = if ENV['CACHE'] == '0'
                    1
                  else
                    THIRTY_DAYS_IN_SECONDS = 60 * 60 * 24 * 30
                  end
  config.default_cassette_options = {
    re_record_interval: cache_timeout,
    record: :new_episodes,
    match_requests_on: [:method, :uri, :body],
  }
  config.cassette_library_dir = "spec/support/fixtures/vcr"
  config.allow_http_connections_when_no_cassette = true
  config.hook_into :typhoeus
end

require 'wirecard_sepa'
