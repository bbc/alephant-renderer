require 'json'

module Alephant
  module Renderer
    class Response
      attr_accessor :content

      def initialize(content)
        @content = content
      end

      def to_json
        ::JSON.generate 'content' => content
      end
    end
  end
end
