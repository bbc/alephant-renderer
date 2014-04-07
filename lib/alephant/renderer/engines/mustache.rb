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

        I18n.load_path << Dir[
          File.join(
            File.expand_path(base_path + '../locale'),
            '*.yml'
          )
        ]
        I18n.load_path.flatten!
        I18n.load_path.uniq!

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
    end

  end
end

