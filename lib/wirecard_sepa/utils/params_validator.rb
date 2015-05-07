module WirecardSepa
  module Utils
    module ParamsValidator
      module_function

      def validate!(params, expected_params)
        if params.keys.sort != expected_params.sort
          raise Errors::InvalidParamsError.new(
            "Please provide a hash exactly with the following keys: #{expected_params}\n" +
            "Missing params: #{expected_params - params.keys}\n" +
            "Unexpected params: #{params.keys - expected_params}"
          )
        end
      end
    end
  end
end
