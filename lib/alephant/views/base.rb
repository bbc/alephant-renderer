require 'mustache'
require 'alephant/views'
require 'hashie'
require 'json'
require 'i18n'

module Alephant::Views
  class Base < Mustache
    attr_accessor :data

    LOCALE = :en

    def initialize(data = {})
      @data = Hashie::Mash.new data
    end

    def t(key, params = {})
      I18n.locale = self.class::LOCALE
      prefix = /\/([^\/]+)\./.match(template_file)[1]
      I18n.translate("#{prefix}.#{key}", params)
    end

    def self.inherited(subclass)
      ::Alephant::Views.register(subclass)
    end
  end
end

