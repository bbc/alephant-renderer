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

            setup
          end

          def to_h
            whitelist.reduce({}) do |accum, method_key|
              accum.tap { |a| a[method_key] = send(methods_key) }
            end
          end

          def setup; end

          def whitelist
            []
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
