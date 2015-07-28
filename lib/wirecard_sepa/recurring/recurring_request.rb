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
        %i( merchant_account_id request_id parent_transaction_id order_number )
      end
    end
  end
end
