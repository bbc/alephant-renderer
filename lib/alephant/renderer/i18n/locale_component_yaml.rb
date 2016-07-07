require "i18n"

module Alephant
  module Renderer
    module I18n
      class LocaleComponentYaml
        def initialize(base_path, locale)
          load_translations_from base_path
          @locale = locale
        end

        def t(key, params = {})
          i18n_lib.locale = @locale
          prefix = %r{/([^\/]+)\.mustache}.match(template_file)[1]
          params[:default] = key unless params[:default]
          i18n_lib.translate("#{prefix}.#{key}", params)
        end

        private

        def load_translations_from(base_path)
          if i18n_lib.load_path.empty?
            i18n_lib.config.enforce_available_locales = false
            i18n_lib.load_path = i18n_load_path_from(base_path)
            i18n_lib.backend.load_translations
          end
        end

        def i18n_load_path_from(base_path)
          Dir[translation_filename(base_path)]
            .flatten
            .uniq
        end

        def translation_filename(base_path)
          File.join(
            Pathname.new(base_path).parent,
            "locale",
            "*.yml")
        end

        def i18n_lib
          ::I18n
        end
      end
    end
  end
end
