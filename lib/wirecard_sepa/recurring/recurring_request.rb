module WirecardSepa
  module Recurring
    class RecurringRequest < DirectDebit::Request
      def expected_params
        # FIXME creditor_id is not needed here
        %i( merchant_account_id creditor_id request_id parent_transaction_id )
      end
    end
  end
end
