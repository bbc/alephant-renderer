require 'spec_helper'
require 'fixtures/components/foo/models/welsh'

describe Alephant::Views::Base do
  let(:base_path) do
    File.join(
      File.dirname(__FILE__),
      'fixtures',
      'components',
      'foo'
    )
  end

  describe "t(key, param{})" do
    it "Translates a key for the default locale" do
      Alephant::Renderer.create('foo', base_path, :model)

      expect(subject.t('bar')).to eq('Translation')
    end

    it "Translates a key for an overridden locale" do
      Alephant::Renderer.create('welsh', base_path, :model)

      expect(Fixtures::Welsh.new.t('bar')).to eq('Welsh Translation')
    end

    it "Uses the translation keys value if no translation and no default set" do
      Alephant::Renderer.create('welsh', base_path, :model)

      expect(Fixtures::Welsh.new.t('non_existent')).to eq('non_existent')
    end
  end

  describe "t(key, param{:default => 'A default'})" do
    it "Uses the passed in default if translation key does not exist" do
      Alephant::Renderer.create('welsh', base_path, :model)

      expect(Fixtures::Welsh.new.t('non_existent', :default => 'A default')).to eq('A default')
    end
  end
end
