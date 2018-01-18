module WirecardSepa
  module DirectDebit
    class Response
      attr_reader :xml, :request

      def self.for_request(request)
        new(request.body, request: request)
      end

      def initialize(xml, request: nil)
        @xml = xml
        @request = request
      end

      def params
        {
          success:               success?,
          transaction_id:        transaction_id,
          transaction_state:     transaction_state,
          status_code:           status_code,
          status_description:    status_description,
          due_date:              due_date,
          reference_id:          provider_transaction_reference_id,
          original_response_xml: xml,
        }
      end

      def success?
        transaction_state == 'success'
      end

      def transaction_id
        value_at 'transaction-id'
      end

      def transaction_state
        value_at 'transaction-state'
      end

      def status_code
        value_at 'status', attribute: :code
      end

      def status_description
        value_at 'status', attribute: :description
      end

      def due_date
        value_at 'due-date'
      end

      def provider_transaction_reference_id
        value_at 'provider-transaction-reference-id'
      end

      def to_s
        xml
      end

      private

      # Returns the text of a node with the given position. If
      # an additional attribute is given, this attribute is returned
      # instead.
      # This method provides mainly nil-safeness.
      def value_at(position, attribute: nil)
        node = xml_doc.at_css(position)
        node or return
        attribute ? node[attribute] : node.text
      end

      def xml_doc
        @xml_doc ||= Nokogiri::XML xml
      end
    end
  end
end
