require 'spec_helper'

describe WirecardSepa::Recurring::FirstRequest do
  subject { described_class.new(params) }
  let(:params) do
    {
      merchant_account_id: 'eefc804c-f9d3-43a8-bd15-a1c92de10000',
      request_id: '67366dbf-c68c-4f4e-a14b-69db83fbdd20',
      requested_amount: '20.02',
      account_holder_first_name: 'John',
      account_holder_last_name: 'Doe',
      bank_account_iban: 'DE42512308000000060004',
      bank_account_bic: 'WIREDEMMXXX',
      mandate_id: '12345678',
      mandate_signed_date: '2013-12-19',
      creditor_id: 'DE98ZZZ09999999999',
    }
  end

  describe '#initialize' do
    it 'raises an Error when unexpected param keys are provided' do
      expect {
        described_class.new({ unexpected_key: 'foo' })
      }.to raise_error WirecardSepa::Errors::InvalidParamsError
    end
  end

  describe '#to_xml' do
    it 'builds the correct xml' do
      expected_xml = read_support_file('recurring/success/first_request.xml')
      expect(subject.to_xml).to eq expected_xml
    end
  end
end
