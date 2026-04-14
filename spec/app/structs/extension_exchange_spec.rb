# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Structs::ExtensionExchange do
  subject :exchange do
    Factory.structs[
      :extension_exchange,
      headers: {"accept" => "application/json"},
      body: {"query" => "test"}
    ]
  end

  describe "#http_attributes" do
    it "answers attributes" do
      expect(exchange.http_attributes).to eq(
        headers: {"accept" => "application/json"},
        verb: "get",
        body: {"query" => "test"}
      )
    end
  end
end
