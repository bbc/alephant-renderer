require_relative './json.rb'
require 'json'

module Alephant
  module Renderer
    module Views
      class Envelope < Json
        def head
          []
        end

        def body_last
          []
        end

        def locale
          :en
        end

        def render
          {
            head:       head,
            bodyInline: renderer_engine.render(self),
            bodyLast:   body_last
          }.to_json
        end

        private

        def renderer_engine
          Alephant::Renderer::Engine::Mustache.new(base_path, template_name)
        end

        def template_name
          Mustache.underscore(self.class.to_s).split('/').last
        end

        def translator
          @translator || Alephant::Renderer::I18n::LocaleComponentYaml.new(locale, template_name)
        end

        def t(key, params = {})
          translator.t(key, params)
        end
      end
    end
  end
end
