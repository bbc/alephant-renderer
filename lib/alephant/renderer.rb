require 'alephant/renderer/version'
require 'alephant/renderer/view_mapper'

module Alephant
  module Renderer
    def self.create(config, data)
      Renderer.new(config, data)
    end

    class Renderer
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
        )
      end
    end
  end
end
