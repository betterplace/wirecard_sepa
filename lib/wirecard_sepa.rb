require 'nokogiri'
require 'wirecard_sepa/version'
require 'wirecard_sepa/request'
require 'wirecard_sepa/response'
require 'wirecard_sepa/gateway'

module WirecardSepa
  SANDBOX_URL = ''
  LIVE_URL    = ''

  def self.sandbox!
    @sandboxed = true
  end

  def self.sandboxed?
    !!@sandboxed
  end

  def self.gateway_url
    sandboxed? ? SANDBOX_URL : LIVE_URL
  end
end
