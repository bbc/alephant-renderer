require 'mustache'

module Alephant
  module Renderer
    module Engine
      class Mustache
        def initialize(base_path, namespace, partials_path = nil)
          @namespace = namespace
          @base_path = base_path
          @partial_path = partials_path || default_shared_partial_path
        end

        def render(data)
          mustache.template_path = @partial_path
          mustache.render(template, data)
        end

        def default_shared_partial_path
          File.join(@base_path, '/../lib/templates')
        end

        def template_path
          File.join(@base_path, 'templates')
        end

        private

        def template_file
          File.join(template_path, "#{@namespace}.#{::Mustache.template_extension}")
        end

        def template
          @template_string ||= File.open(template_file).read
        end

        def mustache
          ::Mustache
        end
      end
    end
  end
end
