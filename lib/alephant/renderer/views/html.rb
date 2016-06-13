require "alephant/renderer/views/base"
require "mustache"
require "i18n"

module Alephant
  module Renderer
    module Views
      class Html < Mustache
        include ::Alephant::Renderer::Views::Base

        def setup
          @content_type = "text/html"
        end

        def locale
          :en
        end

        private

        def template
          @template_string ||= File.open(template_file).read
        end

        def template_name
          Mustache.underscore(self.class.to_s).split("/").last
        end

        def template_file
          File.join(
            base_path,
            "templates",
            "#{template_name}.#{template_extension}"
          )
        end
      end
    end
  end
end
