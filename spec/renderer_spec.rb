require 'spec_helper'

describe Alephant::Renderer do
  subject { Alephant::Renderer }

  let(:config) { 
    {
      renderer_id: 'foo',
      view_path: File.join(File.dirname(__FILE__), 'fixtures/components'),
    }
  }
  let(:data) { {content: 'test'} } 

  describe '.create' do
    context 'using valid params' do
      let(:expected) { Alephant::Renderer::Renderer }

      specify { 
        expect(subject.create(config, data)).to be_instance_of expected
      } 
    end
  end

  describe Alephant::Renderer::Renderer do
    subject { Alephant::Renderer::Renderer.new(config, data) }

    describe '#config' do
      specify { expect(subject.config).to eql config }
    end

    describe '#data' do
      specify { expect(subject.data).to eql data }
    end

    describe '#views' do
      it 'returns a Hash' do
        expect(subject.views).to be_a Hash
      end

      context 'using three Models' do
        it 'returns three Views in Hash' do
          expect(subject.views.length).to eql 3
        end
      end

      context 'using `bar`, `foo`, `json` models' do
        it 'contains a View for `bar` model' do
          expect(subject.views.key? 'bar').to be
        end

        it 'contains a View for `foo` model' do
          expect(subject.views.key? 'foo').to be 
        end

        it 'contains a View for `json` model' do
          expect(subject.views.key? 'json').to be
        end
      end
    end
  end
end
