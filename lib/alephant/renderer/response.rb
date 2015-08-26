require "json"

module Alephant
  module Renderer
    class Response < Struct.new(:content)
      def to_json
        ::JSON.generate "content" => content
      end
    end
  end
end
