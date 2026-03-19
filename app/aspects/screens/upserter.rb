# frozen_string_literal: true

require "dry/monads"

module Terminus
  module Aspects
    module Screens
      # Creates or updates a screen.
      class Upserter
        include Deps[
          "aspects.screens.mold_builder",
          "aspects.screens.upserters.encoded",
          "aspects.screens.upserters.html",
          "aspects.screens.upserters.preprocessed",
          "aspects.screens.upserters.unprocessed"
        ]
        include Dry::Monads[:result]

        def call **parameters
          case parameters
            in label:, name:, content: then handle_html label:, name:, content:, **parameters
            in label:, name:, uri:, preprocessed: true
              handle_preprocessed label:, name:, content: uri, **parameters
            in label:, name:, uri: then handle_unprocessed label:, name:, content: uri, **parameters
            in label:, name:, data:
              handle_encoded_data label:, name:, content: data, **parameters
            else Failure "Invalid parameters: #{parameters.inspect}."
          end
        end

        private

        def handle_html(**) = mold_builder.call(**).bind { html.call it }

        def handle_unprocessed(**) = mold_builder.call(**).bind { unprocessed.call it }

        def handle_preprocessed(**) = mold_builder.call(**).bind { preprocessed.call it }

        def handle_encoded_data(**) = mold_builder.call(**).bind { encoded.call it }
      end
    end
  end
end
