module MyApp
  class Bar < Alephant::Renderer::Views::Html
    def content
      @data[:content]
    end
  end
end
