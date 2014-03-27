require 'mustache'
require 'alephant/views'
require 'hashie'

module Alephant::Views
  class Base < Mustache
    attr_accessor :data

    def initialize(data = {})
      @data = Hashie::Mash.new data
    end

    def self.inherited(subclass)
      ::Alephant::Views.register(subclass)
    end
  end
end

