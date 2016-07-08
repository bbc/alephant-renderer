require "alephant/renderer/views/base"
require "alephant/renderer/engine/mustache"
require "alephant/renderer/i18n/locale_component_yaml"

module Alephant
  module Renderer
    module Views
      class Html
        include ::Alephant::Renderer::Views::Base

        def setup
          @content_type = "text/html"
          @translator = translator
          @renderer = renderer_engine
        end

        def translator
          Alephant::Renderer::I18n::LocaleComponentYaml.new(
            translations_path,
            locale,
            template_name)
        end

        def translations_path
          File.join(
            Pathname.new(base_path).parent,
            "locale")
        end

        def renderer_engine
          Alephant::Renderer::Engine::Mustache.new(template_name)
        end

        def t(key, params = {})
          @translator.t(key, params)
        end

        def locale
          :en
        end

        def render
          @renderer.render Hash(self)
        end

        private

        def template_name
          Mustache.underscore(self.class.to_s).split("/").last
        end
      end
    end
  end
end
