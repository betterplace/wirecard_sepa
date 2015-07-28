require 'spec_helper'

describe WirecardSepa::DirectDebit::Request do
  subject { described_class.new(params) }
  let(:params) do
    {
      order_number: 666,
      merchant_account_id: 'eefc804c-f9d3-43a8-bd15-a1c92de10000',
      request_id: '7f55aacb-3e15-4185-b80f-1e0ad5b51d6c',
      requested_amount: '10.01',
      account_holder_first_name: 'John',
      account_holder_last_name: 'Doe',
      bank_account_iban: 'DE42512308000000060004',
      bank_account_bic: 'WIREDEMMXXX',
      mandate_id: '12345678',
      mandate_signed_date: '2013-09-24',
      creditor_id: 'DE98ZZZ09999999999',
      custom_fields: {
        "Company Name" => "gut.org"
      }
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
      expected_xml = read_support_file('direct_debit/success/request_with_custom_fields.xml')
      expect(subject.to_xml).to eq expected_xml
    end

    it 'builds a valid request' do
      xsd = Nokogiri::XML::Schema(read_support_file('payment.xsd'))
      doc = Nokogiri::XML(subject.to_xml)
      errors = xsd.validate(doc)
      expect(errors).to be_empty
    end
  end
end
