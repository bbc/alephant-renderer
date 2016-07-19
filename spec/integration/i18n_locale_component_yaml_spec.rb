require 'spec_helper'

describe Alephant::Renderer::I18n::LocaleComponentYaml do
  let(:template_path) { File.join(File.dirname(__FILE__), 'fixtures') }
  let(:locale) { 'en' }
  let(:namespace) { 'my_namespace' }

  subject { described_class.new(locale, namespace, template_path) }

  describe 'Performs a translation' do
    it 'should return a translated string in 1 locale' do
      expect(subject.t(:some_string)).to eq('some string')
    end
  end

  describe 'Overridding parameters' do
    it 'should return a translation from a different locale/component' do
      params = {
        locale: 'cy',
        scope:  'other_namespace',
        count:  1
      }
      expect(subject.t(:some_string, params)).to eq('another string')
    end

    it 'should return a pluralized translation with variable substitution' do
      params = {
        locale: 'cy',
        scope:  'other_namespace',
        count:  2
      }
      expect(subject.t(:some_string, params)).to eq('another 2 strings')
    end
  end
end
