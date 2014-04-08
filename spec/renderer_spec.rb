require 'spec_helper'

describe Alephant::Renderer do
  let(:template_file) { 'foo' }
  let(:base_path) { 'bar/baz' }
  let(:model) { :model }

  before(:each) do
    @base_path = File.join(
      File.dirname(__FILE__),
      'fixtures',
      'components',
      'foo'
    )
  end

  describe ".create(template_file, base_path, model)" do
    it "returns a Alephant::Renderer::Mustache" do
      expect(subject.create(template_file, base_path, model)).to be_a Alephant::Renderer::Mustache
    end
  end

  describe Alephant::Renderer::Mustache do
    subject { Alephant::Renderer::Mustache }
    describe "initialize(template_file, base_path, model)" do
      context "template_file = :template_file" do
        it "sets the attribute template_file" do
          expect(subject.new(template_file, base_path, model).template_file).to eq(template_file)
        end
      end
    end

    describe "template()" do
      it "returns the template" do
        instance = subject.new(template_file, @base_path, model)
        template = instance.template
        expect(template).to eq("{{content}}\n")
      end
    end

    describe "render()" do
      it 'renders a template returned from template(template_file)' do
        ::Mustache
        .any_instance
        .stub(:render)
        .with(:template, :model)
        .and_return(:content)

        Alephant::Renderer::Mustache
        .any_instance
        .stub(:template)
        .and_return(:template)

        expect(subject.new(template_file, @base_path, model).render).to eq(:content)
      end
    end
  end
end
