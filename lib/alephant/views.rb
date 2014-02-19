require 'alephant/views/base'

module Alephant
  module Views
    @@views = {}

    def self.register(klass)
      id = ::Alephant::Views.underscorify(
        klass.name.split('::').last
      )

      @@views[id] = klass
    end

    def self.get_registered_class(id)
      @@views[id]
    end

    def self.underscorify(str)
      str.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end
  end
end
