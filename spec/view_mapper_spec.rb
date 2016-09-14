require 'spec_helper'

describe Alephant::Renderer::ViewMapper do
  let(:renderer_id) { 'foo-renderer' }
  let(:data) { { foo: :bar } }
  let(:path) { File.join(File.dirname(__FILE__), 'fixtures/components') }

  subject { Alephant::Renderer::ViewMapper }

  describe 'initialize(view_base_path)' do
    context 'view_base_path = invalid_path' do
      it 'should raise an error' do
        expect do
          subject.new(renderer_id, './invalid_path')
        end.to raise_error ::Alephant::Renderer::Error::InvalidBasePath
      end
    end

    context 'view_base_path = .' do
      it 'sets base_path' do
        expect(
          subject.new(renderer_id, path).base_path
        ).to eq("#{path}/#{renderer_id}")
      end
    end

    context 'view_base_path = nil' do
      it 'sets base_path' do
        expect(
          subject.new(renderer_id).base_path
        ).to eq(Alephant::Renderer::ViewMapper::DEFAULT_LOCATION)
      end
    end
  end

  describe 'generate(data)' do
    it 'calls create_renderer for each template found' do
      expect(
        subject.new(renderer_id, path).generate(data).size
      ).to eq(4)
    end
  end
end
