module WirecardSepa
  module Concerns
    module TemplateLookup
      def template_path
        File.expand_path "../../../templates/#{template_file}", __FILE__
      end

      def template_file
        self.class.name.
          gsub(/(.)([A-Z])/, '\1_\2').
          gsub('::_', '/').
          downcase + '.xml'
      end
    end
  end
end
