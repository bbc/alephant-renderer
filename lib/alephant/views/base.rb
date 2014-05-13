require 'mustache'
require 'alephant/views'
require 'hashie'
require 'json'
require 'i18n'

module Alephant::Views
  class Base < Mustache
    attr_accessor :data

    def initialize(data = {})
      @data = Hashie::Mash.new data
    end

    def locale
      :en
    end

    def t(key, params = {})
      I18n.locale = locale
      prefix = /\/([^\/]+)\.mustache/.match(template_file)[1]
      params.merge! :default => key unless params[:default]
      translation = I18n.translate("#{prefix}.#{key}", params)
    end

    def self.inherited(subclass)
      ::Alephant::Views.register(subclass)
    end
  end
end

