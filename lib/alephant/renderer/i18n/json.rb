require 'json'

module Alephant
  module Renderer
    module I18n
      class Json < LocaleComponentYaml
        private

        def load_translations
          return unless i18n_lib.load_path.empty?
          translations_files.map do |file|
            store_translation(file)
          end
        end

        def store_translation(file)
          translations = JSON.parse(File.read(file))
          translations.each do |locale, content|
            i18n_lib.backend.store_translations(locale, content)
          end
        end

        def translation_filename
          File.join(
            translations_path,
            '*.json')
        end
      end
    end
  end
end
