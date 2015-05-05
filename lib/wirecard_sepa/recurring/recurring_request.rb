module WirecardSepa
  module Recurring
    class RecurringRequest < DirectDebit::Request
      def expected_params
        %i( merchant_account_id request_id parent_transaction_id )
      end
    end
  end
end
