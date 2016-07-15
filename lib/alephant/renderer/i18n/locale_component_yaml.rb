require 'i18n'

module Alephant
  module Renderer
    module I18n
      class LocaleComponentYaml
        def initialize(locale, namespace, translations_path = nil)
          @translations_path = translations_path
          @locale = locale
          @namespace = namespace

          load_translations
        end

        def t(key, params = {})
          i18n_lib.locale = @locale
          params[:default] = key unless params[:default]
          params[:scope] = @namespace unless params[:scope]
          i18n_lib.translate(key, params)
        end

        private

        def load_translations
          return unless i18n_lib.available_locales.empty?
          i18n_lib.backend.load_translations(translations_files)
        end

        def translations_files
          Dir[translation_filename]
            .flatten
            .uniq
        end

        def translation_filename
          File.join(
            translations_path,
            '*.yml')
        end

        def translations_path
          @translations_path || './components/lib/locales'
        end

        def i18n_lib
          i18n_lib = ::I18n
          i18n_lib.enforce_available_locales = false
          i18n_lib
        end
      end
    end
  end
end
