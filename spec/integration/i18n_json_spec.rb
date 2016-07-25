require 'spec_helper'
require File.dirname(__FILE__) + '/../../lib/alephant/renderer/i18n/json'

describe Alephant::Renderer::I18n::Json do
  let(:template_path) { File.join(File.dirname(__FILE__), 'fixtures') }
  let(:locale) { 'en' }
  let(:namespace) { 'my_namespace' }

  subject { described_class.new(locale, namespace, template_path) }

  describe 'json translations' do
    let(:params) do
      {
        locale: 'cy',
        count:  1,
        scope:  'other_namespace'
      }
    end
    it 'should translate a string held in a json document' do
      expect(subject.t(:some_string, params)).to eq('another string')
    end
  end
end
