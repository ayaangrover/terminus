# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Aspects::Extensions::URIBuilder do
  subject(:builder) { described_class.new }

  describe "#call" do
    let :extension do
      Factory.structs[
        :extension,
        fields: [
          {"keyname" => "one", "default" => 1},
          {"keyname" => "two", "default" => 2}
        ]
      ]
    end

    it "answers URIs with default data" do
      expect(builder.call(extension, "https://test.io")).to contain_exactly("https://test.io")
    end

    it "answers URIs with custom data" do
      template = <<~CONTENT
        https://test.io/{{extension.values.one}}
        https://test.io/{{extension.values.two}}
      CONTENT

      expect(builder.call(extension, template)).to eq(%w[https://test.io/1 https://test.io/2])
    end
  end
end
