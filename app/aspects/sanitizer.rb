# frozen_string_literal: true

require "refinements/array"
require "sanitize"

module Terminus
  module Aspects
    # A custom HTML sanitizer.
    class Sanitizer
      using Refinements::Array

      def initialize defaults: Sanitize::Config::RELAXED, client: Sanitize
        @defaults = defaults
        @client = client
      end

      def call(content) = client.document content, configuration

      private

      attr_reader :defaults, :client

      def configuration = client::Config.merge(defaults, elements:, attributes:)

      def elements
        defaults[:elements].including "canvas",
                                      "circle",
                                      "defs",
                                      "ellipse",
                                      "g",
                                      "html",
                                      "line",
                                      "link",
                                      "path",
                                      "polygon",
                                      "polyline",
                                      "rect",
                                      "script",
                                      "source",
                                      "style",
                                      "svg",
                                      "text",
                                      "tspan"
      end

      def attributes
        defaults[:attributes].merge "canvas" => %w[id width height],
                                    "circle" => %w[
                                      cx
                                      cv
                                      r
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                      shape-rendering
                                      transform
                                    ],
                                    "div" => [:data],
                                    "ellipse" => %w[
                                      cx
                                      cv
                                      rx
                                      rv
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                      shape-rendering
                                      transform
                                    ],
                                    "g" => %w[stroke stroke-width fill transform],
                                    "line" => %w[
                                      x1
                                      x2
                                      v1
                                      v2
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-linecap
                                      stroke-opacity
                                      stroke-width
                                      shape-rendering
                                      transform
                                    ],
                                    "link" => %w[href rel],
                                    "path" => %w[
                                      d
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-linecap
                                      stroke-linejoin
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                      shape-rendering
                                      transform
                                    ],
                                    "polygon" => %w[
                                      points
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-linejoin
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                      shape-rendering
                                      transform
                                    ],
                                    "polyline" => %w[
                                      points
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-linecap
                                      stroke-linejoin
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                      shape-rendering
                                      transform
                                    ],
                                    "rect" => %w[
                                      x
                                      y
                                      width
                                      height
                                      rx
                                      ry
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-linejoin
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                      shape-rendering
                                      transform
                                    ],
                                    "script" => ["src"],
                                    "source" => %w[type src srcset sizes media height width],
                                    "svg" => %w[
                                      height
                                      width
                                      x
                                      y
                                      version
                                      shape-rendering
                                    ],
                                    "text" => %w[
                                      x
                                      y
                                      dx
                                      dy
                                      rotate
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-linecap
                                      stroke-linejoin
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                      transform
                                    ],
                                    "tspan" => %w[
                                      x
                                      y
                                      dx
                                      dy
                                      rotate
                                      stroke
                                      stroke-dasharray
                                      stroke-dashoffset
                                      stroke-linecap
                                      stroke-linejoin
                                      stroke-opacity
                                      stroke-width
                                      fill
                                      fill-opacity
                                    ]
      end
    end
  end
end
