require 'spec_helper'

describe WirecardSepa::Gateway do
  let(:config)  { WirecardSepa::Config.for_sandbox }
  let(:gateway) { described_class.new(config) }

  describe '#debit(params)' do
    let(:debit_params) do
      {
        requested_amount: '12.12',
        account_holder_first_name: 'John',
        account_holder_last_name: 'Doe',
        bank_account_iban: 'DE42512308000000060004',
        bank_account_bic: 'WIREDEMMXXX',
        mandate_id: '1235678',
        mandate_signed_date: '2013-09-24',
      }
    end

    it 'post the correct XML' do
      # TODO: Record response from wirecard
      response = gateway.debit(debit_params)
      # FIXME: For some reason wirecard always returns the following error:
      # "The Request Identifier has not been provided.  Please check your input and try again."
      # Status-Code: 400.1010
      expect(response).to be_success
    end
  end
end
