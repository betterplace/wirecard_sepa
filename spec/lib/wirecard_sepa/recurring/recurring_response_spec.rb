require 'spec_helper'

describe WirecardSepa::Recurring::RecurringResponse do
  let(:success_xml) { read_support_file('recurring/success/recurring_response.xml') }
  let(:success_response) { described_class.new success_xml }

  describe '.for_request(request)' do
    let(:request) { double('Fake Typhoeus request', body: '</xml>') }
    let(:response) { described_class.for_request(request) }

    it 'takes a uses the requests body to create a response' do
      expect(response.xml).to eq '</xml>'
    end

    it 'stores the request object for debugging cases' do
      expect(response.request).to eq request
    end
  end

  describe '#params' do
    context 'for a successful response' do
      let(:params) { success_response.params }

      it('params[:transaction_id]')     { expect(params[:transaction_id]).to eq 'e6604f91-663c-11e3-a07b-18037336c0b3' }
      it('params[:transaction_state]')  { expect(params[:transaction_state]).to eq 'success' }
      it('params[:status_code]')        { expect(params[:status_code]).to eq '201.0000' }
      it('params[:status_description]') { expect(params[:status_description]).to eq 'The resource was successfully created.' }
      it('params[:due_date]')           { expect(params[:due_date]).to eq '2014-01-02' }
      it('params[:reference_id]')       { expect(params[:reference_id]).to eq '6A11C85484' }
      it('params[:requested_amount]')   { expect(params[:requested_amount]).to eq '20.02' }
    end
  end

  describe '#success?' do
    it 'returns true for a succesful response' do
      expect(success_response.success?).to eq true
    end
  end

  describe '#to_s' do
    it 'returns the response body' do
      expect(success_response.to_s).to eq success_response.xml
    end
  end
end
