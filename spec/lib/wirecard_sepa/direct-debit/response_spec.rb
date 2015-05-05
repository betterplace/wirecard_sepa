require 'spec_helper'

describe WirecardSepa::DirectDebit::Response do
  let(:success_xml) { read_support_file('direct-debit/success/response.xml') }
  let(:failure_xml) { read_support_file('direct-debit/failure/response.xml') }

  let(:success_response) { described_class.new success_xml }
  let(:failure_response) { described_class.new failure_xml }

  describe '#initialize' do
    let(:request) { double('Fake Request') }

    it 'stores the request if given' do
      response = described_class.new(success_xml, request: request)
      expect(response.request).to eq request
    end
  end

  describe '#params' do
    context 'for a successful response' do
      let(:params) { success_response.params }

      it('params[:transaction_id]')     { expect(params[:transaction_id]).to eq '3971c2d8-250f-11e3-8d4b-005056a97162' }
      it('params[:transaction_state]')  { expect(params[:transaction_state]).to eq 'success' }
      it('params[:status_code]')        { expect(params[:status_code]).to eq '201.0000' }
      it('params[:status_description]') { expect(params[:status_description]).to eq 'The resource was successfully created.' }
      it('params[:due_date]')           { expect(params[:due_date]).to eq '2013-10-03' }
    end
  end

  describe '#success?' do
    it 'returns true for a succesful response' do
      expect(success_response.success?).to eq true
    end

    it 'returns false for a failure response' do
      expect(failure_response.success?).to eq false
    end
  end
end
