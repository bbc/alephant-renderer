require 'alephant/logger'
require 'mustache'

module Alephant
  module Renderer
    class Mustache
      include ::Alephant::Logger

      attr_reader :template_file

      def initialize(template_file, base_path, model)
        @template_file = template_file
        @base_path     = base_path
        @model         = model

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

