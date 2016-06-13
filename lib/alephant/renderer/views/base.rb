require "alephant/renderer/views"
require "hashie"
require "pathname"

module Alephant
  module Renderer
    module Views
      module Base
        def self.included(base)
          base.send :include, InstanceMethods
          base.extend ClassMethods
        end

        module InstanceMethods
          attr_reader :data, :content_type, :base_path

          def initialize(data = {})
            @data = Hashie::Mash.new data
            @base_path = self.class.base_path

            load_translations_from(base_path)

            setup
          end

          def to_h
            whitelist.reduce({}) do |accum, method_key|
              accum.tap { |a| a[method_key] = send(method_key) }
            end
          end

          def setup; end

          def whitelist
            []
          end

          private

          def load_translations_from(base_path)
            if I18n.load_path.empty?
              I18n.config.enforce_available_locales = false
              I18n.load_path = i18n_load_path_from(base_path)
              I18n.backend.load_translations
            end
          end

          def i18n_load_path_from(base_path)
            Dir[
              File.join(Pathname.new(base_path).parent, "locale", "*.yml")
            ].flatten.uniq
          end

          def t(key, params = {})
            I18n.locale = locale
            prefix = /\/([^\/]+)\.mustache/.match(template_file)[1]
            params[:default] = key unless params[:default]
            I18n.translate("#{prefix}.#{key}", params)
          end
        end

        module ClassMethods
          attr_accessor :base_path

          def inherited(subclass)
            current_dir = File.dirname(caller.first[/\/[^:]+/])
            dir_path    = Pathname.new(File.join(current_dir, "..")).realdirpath

            subclass.base_path = dir_path.to_s

            Alephant::Renderer::Views.register(subclass)
          end
        end
      end
    end
  end
end
