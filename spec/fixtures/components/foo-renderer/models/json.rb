module MyApp
  class Json < Alephant::Renderer::Views::Json
    def whitelist
      %w(item1 item2)
    end

    def item1
      @data[:foo]
    end

    def item2
      @data[:bar]
    end

    def baz
      @data[:baz]
    end
  end
end
