module WirecardSepa
  module DirectDebit
    class Response
      attr_reader :xml

      def initialize(xml)
        @xml = xml
      end

      def params
        {
          success: success?,
          transaction_id: transaction_id,
          transaction_state: transaction_state,
          status_code: status_code,
          status_description: status_description,
          due_date: due_date,
          reference_id: provider_transaction_reference_id,
          original_response_xml: xml,
        }
      end

      def success?
        status_code == '201.0000'
      end

      private

      def transaction_id
        xml_doc.at_css('transaction-id').text
      end

      def transaction_state
        xml_doc.at_css('transaction-state').text
      end

      def status_code
        xml_doc.at_css('status')[:code]
      end

      def status_description
        xml_doc.at_css('status')[:description]
      end

      def due_date
        xml_doc.at_css('due-date').text
      end

      def provider_transaction_reference_id
        xml_doc.at_css('provider-transaction-reference-id').text
      end

      def xml_doc
        @xml_doc ||= Nokogiri::XML xml
      end
    end
  end
end
