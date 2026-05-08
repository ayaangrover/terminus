# frozen_string_literal: true

require "hanami_helper"

RSpec.describe Terminus::Aspects::Screens::FindOrCreator, :db do
  subject(:creator) { described_class.new }

  describe "#call" do
    let(:model) { Factory[:model] }

    it "answers existing screen when found" do
      screen = Factory[:screen, model_id: model.id, name: "test", label: "Test"]

      expect(creator.call(name: "test", model_id: model.id).success).to have_attributes(
        id: screen.id,
        label: "Test",
        name: "test"
      )
    end

    it "answers new screen when not found" do
      result = creator.call model_id: model.id,
                            label: "Test",
                            name: "test",
                            content: "<h1>Test</h1>"

      expect(result.success).to have_attributes(
        model_id: model.id,
        name: "test",
        label: "Test",
        image_attributes: hash_including(
          metadata: hash_including(
            size: kind_of(Integer),
            width: 800,
            height: 480,
            filename: "test.png",
            mime_type: "image/png"
          )
        )
      )
    end
  end
end
