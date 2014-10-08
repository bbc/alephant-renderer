require 'alephant/renderer/version'
require 'alephant/renderer/view_mapper'
require 'alephant/support/parser'

module Alephant
  module Renderer
    def self.create(config, message)
      Renderer.new(config, message)
    end

    class Renderer
      attr_reader :config, :message

      def initialize(config, message)
        @config  = config
        @message = message
      end

      def views
        mapper.generate data
      end

      private

      def data
        @data ||= parser.parse message
      end

      def mapper
        @mapper ||= ViewMapper.new(
          config[:renderer_id],
          config[:view_path]
        )
      end

      def parser
        @parser ||= Support::Parser.new(
          config[:msg_vary_id_path]
        )
      end
    end
  end
end
