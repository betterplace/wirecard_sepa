require 'spec_helper'

describe WirecardSepa::Recurring::FirstResponse do
  let(:success_xml) { read_support_file('recurring/success/first_response.xml') }
  let(:success_response) { described_class.new success_xml }

  describe '#params' do
    context 'for a successful response' do
      let(:params) { success_response.params }

      it('params[:transaction_id]')     { expect(params[:transaction_id]).to eq 'e6604f91-663c-11e3-a07b-18037336c0b3' }
      it('params[:transaction_state]')  { expect(params[:transaction_state]).to eq 'success' }
      it('params[:status_code]')        { expect(params[:status_code]).to eq '201.0000' }
      it('params[:status_description]') { expect(params[:status_description]).to eq 'The resource was successfully created.' }
      it('params[:due_date]')           { expect(params[:due_date]).to eq '2014-01-02' }
      it('params[:reference_id]')       { expect(params[:reference_id]).to eq '5A00C85484' }
    end
  end

  describe '#success?' do
    it 'returns true for a succesful response' do
      expect(success_response.success?).to eq true
    end
  end
end
