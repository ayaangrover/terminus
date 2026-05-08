# frozen_string_literal: true

require "refinements/array"
require "sanitize"

module Terminus
  module Aspects
    # A custom HTML sanitizer.
    class Sanitizer
      using Refinements::Array

      def initialize configuration_path: Hanami.app.root.join("config/sanitize.yml"),
                     defaults: Sanitize::Config::RELAXED,
                     client: Sanitize
        @configuration_path = configuration_path
        @defaults = defaults
        @client = client
      end

      def call(content) = client.document content, configuration

      private

      attr_reader :configuration_path, :defaults, :client

      def configuration = client::Config.merge(defaults, elements:, attributes:)

      def elements
        defaults[:elements].including YAML.load_file(configuration_path).fetch("elements")
      end

      def attributes
        defaults[:attributes].merge YAML.load_file(configuration_path).fetch("attributes")
      end
    end
  end
end
