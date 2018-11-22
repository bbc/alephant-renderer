require 'alephant/logger'

module Alephant
  module Renderer
    module Error
      class InvalidBasePath < StandardError
        include Logger

        def initialize(path)
          super "Path '#{path}' to renderer/queue directory is invalid"

          logger.metric('ViewMapperInvalidPath')
          logger.error(
            event: :ViewMapperInvalidPath,
            path:  path
          )
        end
      end
    end
  end
end
