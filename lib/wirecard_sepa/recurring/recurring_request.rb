module WirecardSepa
  module Recurring
    class FirstRequest
      TEMPLATE_PATH = File.expand_path('../../../templates/recurring/recurring_request.xml', __FILE__)
      REQUIRED_PARAMS = %i(
        merchant_account_id request_id requested_amount account_holder_first_name
        account_holder_last_name bank_account_iban bank_account_bic mandate_id
        mandate_signed_at creditor_id
      )

      InvalidParamsError = Class.new StandardError

      def initialize(opts = {})
      end

      private

      def request_id
      end
    end
  end
end
