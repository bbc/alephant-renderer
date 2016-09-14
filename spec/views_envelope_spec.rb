require 'spec_helper'
require 'fixtures/components/foo-renderer/models/envelope'

describe Alephant::Renderer::Views::Envelope do
  let(:data) do
    {
      'foo' => 'envelope'
    }
  end

  describe '#content_type' do
    it 'sets the correct content type' do
      expect(MyApp::Envelope.new(data).content_type).to eq('application/json')
    end
  end

  describe '#render' do
    it 'returns generated envelope' do
      expected_result = '{"head":["some/css/asset/path","some/js/asset/path"],"bodyInline":"<h1>Hello, I\'m a envelope template</h1>","bodyLast":["some/thing/to/add/after/body","some/other/thing/to/add/after/body"]}'
      expect(MyApp::Envelope.new(data).render).to eq(expected_result)
    end
  end

end
