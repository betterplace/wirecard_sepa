require 'spec_helper'

describe WirecardSepa::Recurring::RecurringRequest do
  subject { described_class.new(params) }
  let(:params) do
    {
      merchant_account_id: 'eefc804c-f9d3-43a8-bd15-a1c92de10000',
      request_id: '55566dbf-c68c-4f4e-a14b-69db83fbd555',
      parent_transaction_id: 'e6604f91-663c-11e3-a07b-18037336c0b3',
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
      expected_xml = read_support_file('recurring/success/recurring_request.xml')
      expect(subject.to_xml).to eq expected_xml
    end
  end
end

