require 'alephant/renderer/version'
require 'alephant/renderer/view_mapper'
require 'alephant/logger'

module Alephant
  module Renderer
    def self.create(config, data)
      Renderer.new(config, data)
    end

    class Renderer
      include Logger

      attr_reader :config, :data

      def initialize(config, data)
        @config = config
        @data   = data
      end

      def views
        mapper.generate data
      end

      private

      def mapper
        logger.info "Renderer#mapper: renderer id '#{config[:renderer_id]}', view path '#{config[:view_path]}'"
        @mapper ||= ViewMapper.new(
          config[:renderer_id],
          config[:view_path]
        )
      end
    end
  end
end
