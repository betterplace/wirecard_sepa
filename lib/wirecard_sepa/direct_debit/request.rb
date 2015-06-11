module WirecardSepa
  module DirectDebit
    class Request
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
        %i( merchant_account_id request_id requested_amount
          account_holder_first_name account_holder_last_name bank_account_iban
          bank_account_bic mandate_id mandate_signed_date creditor_id order_number )
      end
    end
  end
end
