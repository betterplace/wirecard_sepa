require 'spec_helper'

describe WirecardSepa::Config do
  let(:config) { described_class.new(valid_params) }
  let(:valid_params) do
    {
      api_url: 'http://example.com',
      http_auth_username: 'alice',
      http_auth_password: 'secret',
      merchant_account_id: '123',
      creditor_id: '31415',
    }
  end

  describe '#http_auth_username' do
    it 'returns the http auth username' do
      expect(config.http_auth_username).to eq 'alice'
    end
  end

  describe '#http_auth_password' do
    it 'returns the http auth password' do
      expect(config.http_auth_password).to eq 'secret'
    end
  end
end
