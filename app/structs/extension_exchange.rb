# frozen_string_literal: true

module Terminus
  module Structs
    # The extension exchange struct.
    class ExtensionExchange < DB::Struct
      def http_attributes = {headers:, verb:, body:}
    end
  end
end
