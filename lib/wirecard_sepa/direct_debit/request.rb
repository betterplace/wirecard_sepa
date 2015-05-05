module WirecardSepa
  module DirectDebit
    class Request
      attr_reader :params

      def initialize(params = {})
        if params.keys.sort != expected_params.sort
          # TODO: Provide link to official wirecard spec which explains the use of the keys
          raise Errors::InvalidParamsError.new(
            "Please provide a hash exactly with the following keys: #{expected_params}\n" +
            "Missing params: #{expected_params - params.keys}\n" +
            "Unexpected params: #{params.keys - expected_params}"
          )
        end
        @params = params
      end

      def to_xml
        xml_template = File.read template_path
        xml_template.gsub /{{\w+}}/, template_params
      end

      protected

      def expected_params
        %i( merchant_account_id request_id requested_amount
          account_holder_first_name account_holder_last_name bank_account_iban
          bank_account_bic mandate_id mandate_signed_date creditor_id )
      end

      private

      def template_path
        File.expand_path "../../../templates/#{template_file}", __FILE__
      end

      def template_file
        self.class.name.
          gsub(/(.)([A-Z])/, '\1_\2').
          gsub('::_', '/').
          downcase + '.xml'
      end

      def template_params
        params.each_with_object({}) { |(k,v), h| h["{{#{k.upcase}}}"] = v }
      end
    end
  end
end
