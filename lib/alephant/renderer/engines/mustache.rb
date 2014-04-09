require 'alephant/logger'
require 'mustache'
require 'i18n'

module Alephant
  module Renderer
    class Mustache
      include ::Alephant::Logger

      attr_reader :template_file

      def initialize(template_file, base_path, model)
        @template_file = template_file
        @base_path     = base_path
        @model         = model

        load_translations_from base_path

        logger.info("Renderer.initialize: end with @base_path set to #{@base_path}")
      end

      def render
        logger.info("Renderer.render: rendered template #{template_file}")
        ::Mustache.render(template, @model)
      end

      def template
        template_location = File.join(@base_path, 'templates', "#{template_file}.mustache")

        begin
          logger.info("Renderer.template: #{template_location}")
          File.open(template_location).read
        rescue Exception => e
          logger.error("Renderer.template: view template #{template_file} not found")
        end
      end

      private

      def load_translations_from(base_path)
        if I18n.load_path.empty?
          I18n.config.enforce_available_locales = false
          I18n.load_path << i18n_load_path_from(base_path)
          I18n.backend.load_translations
        end
      end

      def i18n_load_path_from(base_path)
        Dir[
          File.join(
            Pathname.new(base_path).parent,
            'locale',
            '*.yml')
        ]
        .flatten
        .uniq
      end

    end

  end
end

