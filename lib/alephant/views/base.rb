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

    def t(*args)
      I18n.locale = self.class::LOCALE
      lambda do |comma_delimited_args|
        args   = comma_delimited_args.strip.split ','
        key    = args.shift
        params = args.empty? ? {} : JSON.parse(args.first).with_indifferent_access
        prefix = /\/([^\/]+)\./.match(template_file)[1]

        I18n.translate("#{prefix}.#{key}", params)
      end
    end

    def self.inherited(subclass)
      ::Alephant::Views.register(subclass)
    end
  end
end

