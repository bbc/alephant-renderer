module Alephant
  module Renderer
    module Error
      class InvalidBasePath < StandardError
        def initialize(path)
          super "Path '#{path}' to renderer/queue directory is invalid"
        end
      end
    end
  end
end
