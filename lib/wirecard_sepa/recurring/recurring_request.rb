module WirecardSepa
  module Recurring
    class RecurringRequest
      attr_reader :params

      def initialize(params = {})
        Utils::ParamsValidator.validate!(params, expected_params)
        @params = params
      end

      def to_xml
        Utils::Template.new(self).to_xml
      end

      private

      def expected_params
        # FIXME creditor_id is not needed here
        %i( merchant_account_id creditor_id request_id parent_transaction_id )
      end
    end
  end
end
