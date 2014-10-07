require 'spec_helper'

describe Alephant::Renderer::ViewMapper do
  let(:component_id) { :foo }
  let(:data) {{ :foo => :bar }}
  let(:path) { File.join(File.dirname(__FILE__), 'fixtures/components') }

  subject { Alephant::Renderer::ViewMapper }

  describe "initialize(view_base_path)" do
    context "view_base_path = invalid_path" do
      it "should raise an error" do
        expect {
          subject.new(component_id, './invalid_path')
        }.to raise_error
      end
    end

    context "view_base_path = '.'" do
      it "sets base_path" do
        expect(
          subject.new(component_id, path).base_path
        ).to eq("#{path}/#{component_id}")
      end
    end

    context "view_base_path = nil" do
      it "sets base_path" do
        expect(
          subject.new(component_id).base_path
        ).to eq(Alephant::Renderer::ViewMapper::DEFAULT_LOCATION)
      end
    end
  end

  describe "generate(data)" do
    it "calls create_renderer for each template found" do
      expect(
        subject.new(component_id, path).generate(data).size
      ).to eq(3)
    end
  end
end
