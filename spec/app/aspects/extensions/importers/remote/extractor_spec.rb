# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Aspects::Extensions::Importers::Remote::Extractor do
  subject(:extractor) { described_class.new }

  describe "#call" do
    it "successfully imports plugin" do
      expect(extractor.call(150460)).to match(
        Success(
          hash_including(
            settings: kind_of(String),
            full: kind_of(String),
            half_horizontal: kind_of(String),
            half_vertical: kind_of(String),
            quadrant: kind_of(String),
            shared: kind_of(String)
          )
        )
      )
    end

    it "answers failure when zip can't be decompressed" do
      client = class_double Zip::File
      extractor = described_class.new(client:)

      allow(client).to receive(:open_buffer).and_raise Zip::Error, "Danger!"

      expect(extractor.call(150460)).to be_failure("Danger!")
    end
  end
end
