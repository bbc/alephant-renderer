require "mustache"

module Alephant
  module Renderer
    module Engine
      class Mustache
        def initialize(base_path, namespace)
          @mustache = ::Mustache.new
          @namespace = namespace
          @base_path = base_path
        end

        def template
          @template_string ||= File.open(template_file).read
        end

        def template_file
          File.join(
            @base_path,
            "templates",
            "#{@namespace}.#{::Mustache.template_extension}"
          )
        end

        def render(data)
          @mustache.render(template, data)
        end
      end
    end
  end
end
