require "spec_helper"

describe Alephant::Renderer::I18n::LocaleComponentYaml do
  let(:base_path) { File.join(File.dirname(__FILE__), "fixtures") }
  let(:locale) { "en" }
  let(:namespace) { "my_namespace" }

  subject { described_class.new(base_path, locale, namespace) }

  describe "Performs a translation" do
    it "should return a translated string in 1 locale" do
      expect(subject.t(:some_string)).to eq("some string")
    end
  end

  describe "Overridding parameters" do
    it "should return a translation from a different locale/component" do
      params = {
        :locale => "cy",
        :scope  => "other_namespace",
        :count  => 1
      }
      expect(subject.t(:some_string, params)).to eq("another string")
    end
  end
end
