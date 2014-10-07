module Alephant
  module Renderer
    module Views
      @@views = {}

      def self.register(klass)
        @@views[underscorify(klass.name.split('::').last)] = klass
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
end
