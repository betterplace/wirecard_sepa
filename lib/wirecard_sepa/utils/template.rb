module WirecardSepa
  module Utils
    class Template
      attr_reader :request

      def initialize(request)
        @request = request
      end

      def to_xml
        xml_template = File.open template_path, "r:UTF-8", &:read
        xml_template.gsub /{{\w+}}/, request_params
      end

      private

      def request_params
        request.params.each_with_object({}) do |(k,v), h|
          h["{{#{k.upcase}}}"] = v
        end
      end

      def template_path
        File.expand_path "../../../templates/#{template_file}", __FILE__
      end

      def template_file
        request.class.name.
          gsub(/(.)([A-Z])/, '\1_\2').
          gsub('::_', '/').
          downcase + '.xml'
      end
    end
  end
end
