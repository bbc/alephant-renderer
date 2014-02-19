require 'alephant/views/base'

module Alephant
  module Views
    @@views = {}

    def self.register(klass)
      id = klass.name.split('::').last
      self.underscorify(id)

      @@views[id.underscore] = klass
    end

    def self.get_registered_class(id)
      @@views[id]
    end

    def self.underscorify(str)
      unless str.respond_to? :underscore
        str.instance_eval do
          def underscore
            self.gsub(/::/, '/').
              gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
              gsub(/([a-z\d])([A-Z])/,'\1_\2').
              tr("-", "_").
              downcase
          end
        end
      end
    end
  end
end
