require "spec_helper"
require "fixtures/components/foo-renderer/models/json"

describe Alephant::Renderer::Views::Json do
  let(:data) {
    {
      "foo" => "a",
      "bar" => "b",
      "baz" => "c"
    }
  }

  describe "#content_type" do
    it "sets the correct content type" do
      expect(MyApp::Json.new(data).content_type).to eq("application/json")
    end
  end

  describe "#to_h" do
    it "generates a hash based on the white list" do
      expected_result = { "item1" => "a", "item2" => "b" }
      expect(MyApp::Json.new(data).to_h).to eq(expected_result)
    end
  end

  describe "#render" do
    it "returns generated json" do
      expected_result = "{\"item1\":\"a\",\"item2\":\"b\"}"
      expect(MyApp::Json.new(data).render).to eq(expected_result)
    end
  end
end
