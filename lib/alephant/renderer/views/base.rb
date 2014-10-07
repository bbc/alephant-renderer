require 'alephant/renderer/views'
require 'hashie'

module Alephant
  module Renderer
    module Views
      module Base
        def self.included base
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
            whitelist.reduce({}) { |m,s| m.tap { |m| m[s] = self.send(s) } }
          end

          def setup; end
          def whitelist; [] end
        end

        module ClassMethods
          attr_accessor :base_path

          def inherited(subclass)
            current_dir = File.dirname(caller.first[/\/[^:]+/])
            dir_path    = Pathname.new(File.join(current_dir,'..')).realdirpath

            subclass.base_path = dir_path.to_s

            Alephant::Renderer::Views.register(subclass)
          end
        end
      end
    end
  end
end
