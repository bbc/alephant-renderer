require "mustache"

module Alephant
  module Renderer
    module Engine
      class Mustache
        def initialize(namespace)
          @mustache = ::Mustache.new
          @namespace = namespace
        end

        def template
          @template_string ||= File.open(template_file).read
        end

        def template_file
          File.join(
            base_path,
            "templates",
            "#{namespace}.#{template_extension}"
          )
        end

        def render(data)
          @mustache.render(template, data)
        end
      end
    end
  end
end
