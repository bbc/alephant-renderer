require 'mustache'
require 'alephant/views'

require 'i18n'

module Alephant::Views
  class Base < Mustache
    attr_accessor :data, :locale

    def initialize(data = {})
      @data = data
      @locale = 'en'
    end

    def locale=(l)
      @locale = l
    end

    def t(*args)
      I18n.locale = @locale
      I18n.t(*args)
    end

    def self.inherited(subclass)
      ::Alephant::Views.register(subclass)
    end
  end
end

