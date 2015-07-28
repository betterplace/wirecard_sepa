require 'spec_helper'

# TODOs
# [x] Record response from wirecard w/ VCR
describe WirecardSepa::Gateway do
  let(:gateway) { described_class.new(sandbox_gateway_config) }

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
        order_number: 666,
        custom_fields: {
          'Company Name' => 'gut.org'
        }
      }
    end

    it 'posts the correct XML' do
      VCR.use_cassette 'gateway.debit' do
        response = gateway.debit(debit_params)
        expect(response).to be_success
        expect(response.params).to_not be_empty
        expect(response.transaction_id).to_not be_empty
      end
    end
  end # describe

  describe '#recurring_init(params)' do
    let(:recurring_init_params) do
      {
        requested_amount: '15.00',
        account_holder_first_name: 'Bob',
        account_holder_last_name: 'Hawk',
        bank_account_iban: 'DE42512308000000060004',
        bank_account_bic: 'WIREDEMMXXX',
        mandate_id: '2356789',
        mandate_signed_date: '2013-08-11',
        order_number: 666,
      }
    end

    it 'posts the correct XML' do
      VCR.use_cassette 'gateway.recurring_init' do
        response = gateway.recurring_init(recurring_init_params)
        expect(response).to be_success
        expect(response.params).to_not be_empty
        expect(response.transaction_id).to_not be_empty
      end
    end
  end # describe

  describe '#recurring_process(params)' do
    let(:recurring_init_params) do
      {
        requested_amount: '15.00',
        account_holder_first_name: 'Bob',
        account_holder_last_name: 'Hawk',
        bank_account_iban: 'DE42512308000000060004',
        bank_account_bic: 'WIREDEMMXXX',
        mandate_id: '2356789',
        mandate_signed_date: '2013-08-11',
        order_number: 666,
      }
    end

    let(:parent_transaction_id) do
      VCR.use_cassette 'gateway.recurring_process/init' do
        init_response = gateway.recurring_init(recurring_init_params)
        init_response.transaction_id
      end
    end

    it 'posts the correct XML' do
      VCR.use_cassette 'gateway.recurring_process' do
        response = gateway.recurring_process({ parent_transaction_id: parent_transaction_id, order_number: 667 })
        expect(response).to be_success
        expect(response.params).to_not be_empty
        expect(response.transaction_id).to_not be_empty
      end
    end
  end # describe
end
