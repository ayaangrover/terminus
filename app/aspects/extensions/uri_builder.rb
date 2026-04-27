# frozen_string_literal: true

module Terminus
  module Aspects
    module Extensions
      # A specialized URI builder based template and data to produce an array of fully formed URIs.
      class URIBuilder
        include Deps["aspects.extensions.contextualizer", renderer: "liquid.basic"]

        def call extension, template
          contextualizer.call(extension)
                        .then { |data| renderer.call(template, data).split }
        end
      end
    end
  end
end
