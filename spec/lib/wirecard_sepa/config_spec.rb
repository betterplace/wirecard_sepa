require 'spec_helper'

describe WirecardSepa::Config do
  let(:valid_params) do
    {
      http_auth_username: 'alice',
      http_auth_password: 'secret',
      merchant_account_id: '123',
      merchant_account_name: 'alice-merchant',
      creditor_id: '31415',
    }
  end

  describe '#initialize' do
    it 'returns a config object when all required params are given' do
      config = described_class.new(valid_params)
    end

    it 'raises an Error when unexpected param keys are provided' do
      expect {
        described_class.new(valid_params.merge({ unexpected_key: 'foo' }))
      }.to raise_error WirecardSepa::Errors::InvalidParamsError
    end
  end

  describe '.for_sandbox' do
    it 'returns a config object with the correct sandbox settings' do
      config = described_class.for_sandbox
      expect(config[:http_auth_username]).to eq '70000-APITEST-AP'
      expect(config[:http_auth_password]).to eq 'qD2wzQ_hrc!8'
      expect(config[:merchant_account_id]).to eq '4c901196-eff7-411e-82a3-5ef6b6860d64'
      expect(config[:merchant_account_name]).to eq 'WD SEPA Test'
      expect(config[:creditor_id]).to eq 'abcdef'
    end
  end
end
