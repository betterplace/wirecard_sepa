module WirecardSepa
  module Utils
    class Template
      attr_reader :request

      def initialize(request)
        @request = request
      end

      def to_xml
        xml_template = File.open template_path, "r:UTF-8", &:read
        xml_template.gsub(/{{\w+}}/, request_params)#.tap { byebug }
      end

      private

      def request_params
        params_without_custom_fields.each_with_object({}) do |(k,v), h|
          h["{{#{k.upcase}}}"] = v
        end.merge('{{CUSTOM_FIELDS}}' => custom_fields_xml)
      end

      def params_without_custom_fields
        request.params.reject { |k,_| k == :custom_fields }
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

      def custom_fields_xml
        # TODO: Refactor me :>
        custom_fields = request.params[:custom_fields] || Hash.new
        return '' if custom_fields.empty?
        fields_xml = custom_fields.map do |k,v|
          "  <custom-field field-name=\"#{k}\" field-value=\"#{v}\"/>\n"
        end.join.to_s
        '<custom-fields>' "\n" +
        "  #{fields_xml}" +
        '  </custom-fields>'
      end
    end
  end
end
