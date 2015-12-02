require "alephant/renderer/version"
require "alephant/renderer/view_mapper"
require "alephant/logger"

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
        @mapper ||= ViewMapper.new(
          config[:renderer_id],
          config[:view_path]
        ).tap do
          logger.info(
            "event"      => "ViewMapperCreated",
            "rendererId" => config[:renderer_id],
            "viewPath"   => config[:view_path],
            "method"     => "#{self.class}#mapper"
          )
        end
      end
    end
  end
end
