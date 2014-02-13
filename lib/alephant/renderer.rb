require 'alephant/renderer/version'
require 'alephant/renderer/engines/mustache'

module Alephant
  module Renderer

    def self.create(*args)
      Mustache.new(*args)
    end

  end
end
