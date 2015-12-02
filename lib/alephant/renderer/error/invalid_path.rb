module Alephant
  module Renderer
    module Error
      class InvalidBasePath < StandardError
        def initialize(path)
          super "The provided base path '#{path}' to your renderer/queue directory appears to be invalid"
        end
      end
    end
  end
end
