require 'mustache'

module Alephant
  module Renderer
    module Engine
      class Mustache
        def initialize(base_path, namespace, partials_path = nil)
          @namespace = namespace
          @base_path = base_path

          @mustache = ::Mustache.new
          @mustache.class.template_path = partials_path || default_shared_template_path
        end

        def template
          @template_string ||= File.open(template_file).read
        end

        def default_shared_template_path
          File.join(@base_path, '/../lib/templates')
        end

        def template_path
          File.join(@base_path, 'templates')
        end

        def template_file
          File.join(template_path, "#{@namespace}.#{::Mustache.template_extension}")
        end

        def render(data)
          @mustache.render(template, data)
        end
      end
    end
  end
end
