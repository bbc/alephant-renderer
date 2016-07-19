require 'spec_helper'

describe Alephant::Renderer::Engine::Mustache do
  let(:base_path) { File.join(File.dirname(__FILE__), 'fixtures') }
  let(:namespace) { 'sample' }

  subject { described_class.new(base_path, namespace) }

  describe 'Renders a template' do
    it 'should render some data to a template' do
      data = {
        item1: 'AAA',
        item2: 'bbb'
      }
      expect(subject.render(data)).to eq('<span>AAA</span><span>bbb</span>')
    end
  end
end
