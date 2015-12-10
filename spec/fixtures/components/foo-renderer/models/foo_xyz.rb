module MyApp
  class FooXyz < Alephant::Renderer::Views::Html
    def content
      @data[:content]
    end
  end
end
