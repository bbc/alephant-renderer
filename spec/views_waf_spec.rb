require 'spec_helper'
require 'fixtures/components/foo-renderer/models/waf'

describe Alephant::Renderer::Views::Waf do
  let(:data) do
    {
      'foo' => 'waf'
    }
  end

  describe '#content_type' do
    it 'sets the correct content type' do
      expect(MyApp::Waf.new(data).content_type).to eq('application/json')
    end
  end

  describe '#render' do
    it 'returns generated envelope' do
      expected_result = '{"head":["some/css/asset/path","some/js/asset/path"],"bodyInline":"<h1>Hello, I\'m a waf template</h1>","bodyLast":["some/thing/to/add/after/body","some/other/thing/to/add/after/body"]}'
      expect(MyApp::Waf.new(data).render).to eq(expected_result)
    end
  end

end
