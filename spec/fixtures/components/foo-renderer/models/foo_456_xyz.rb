module MyApp
  class Foo456Xyz < Alephant::Renderer::Views::Html
    def content
      @data[:content]
    end
  end
end
