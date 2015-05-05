module WirecardSepa
  module DirectDebit
    class Request
      EXPECTED_PARAMS = %i( merchant_account_id request_id requested_amount
        account_holder_first_name account_holder_last_name bank_account_iban
        bank_account_bic mandate_id mandate_signed_date creditor_id )
      TEMPLATE_PATH = File.expand_path '../../../templates/direct-debit/request.xml', __FILE__

      attr_reader :params

      def initialize(params = {})
        if params.keys.sort != EXPECTED_PARAMS.sort
          # TODO: Provide link to official wirecard spec which explains the use of the keys
          raise Errors::InvalidParamsError.new(
            "Please provide a hash exactly with the following keys: #{EXPECTED_PARAMS}\n" +
            "Missing params: #{EXPECTED_PARAMS - params.keys}\n" +
            "Unexpected params: #{params.keys - EXPECTED_PARAMS}"
          )
        end
        @params = params
      end

      def to_xml
        xml_template = File.read TEMPLATE_PATH
        xml_template.gsub /{{\w+}}/, template_params
      end

      private

      def template_params
        params.each_with_object({}) { |(k,v), h| h["{{#{k.upcase}}}"] = v }
      end
    end
  end
end
