require 'nokogiri'
require 'wirecard_sepa/version'
require 'wirecard_sepa/errors'
require 'wirecard_sepa/direct-debit/request'
require 'wirecard_sepa/direct-debit/response'
require 'wirecard_sepa/recurring/first_request'
require 'wirecard_sepa/recurring/first_response'
require 'wirecard_sepa/recurring/recurring_request'
require 'wirecard_sepa/recurring/recurring_response'
require 'wirecard_sepa/config'
require 'wirecard_sepa/gateway'

module WirecardSepa
  SANDBOX_URL = 'https://api-test.wirecard.com/engine/rest/paymentmethods/'
  LIVE_URL    = ''

  def self.sandbox!
    @live = true
  end

  def self.sandboxed?
    !@live
  end

  def self.gateway_url
    sandboxed? ? SANDBOX_URL : LIVE_URL
  end
end
