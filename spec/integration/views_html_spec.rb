require 'spec_helper'
require_relative 'fixtures/components/test-renderer/models/legacy_module'
require_relative 'fixtures/components/test-renderer/models/legacy_shared_module'
require_relative 'fixtures/components/test-renderer/models/translating_module'

describe Alephant::Renderer::Views::Html do
  let(:data) { nil }
  let(:test_renderer) { MyApp::LegacyModule }

  subject { test_renderer.new(data) }

  describe 'Interface tests (backwards compatibility)' do
    it 'should accept self.template_path calls' do
      expect(subject.class.template_path).to eq('/ignored/path/to/templates')
    end

    it 'should render from a local template (with template_path set)' do
      expect(subject.render).to eq('legacy module template')
    end

    describe 'Shared template test' do
      let(:test_renderer) { MyApp::LegacySharedModule }

      it 'should render a local template that points to a shared template (with template_path set)' do
        expect(subject.render).to eq('legacy shared module template')
      end
    end
  end

  describe 'Interface tests' do
    describe 'Translation test' do
      before(:all) do
        ::I18n.backend = I18n::Backend::Simple.new
      end

      let(:test_renderer) { MyApp::TranslatingModule }

      it 'should render a template with a translated string' do
        expect(subject.render).to eq('modern shared module template')
      end
    end
  end
end
