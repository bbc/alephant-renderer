require "alephant/renderer/views/base"
require "json"

module Alephant
  module Renderer
    module Views
      class Json
        include ::Alephant::Renderer::Views::Base

        def setup
          @content_type = "application/json"
        end

        def render
          ::JSON.generate to_h
        end
      end
    end
  end
end
