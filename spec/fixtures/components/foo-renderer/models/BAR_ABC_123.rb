module MyApp
  class BarAbc123 < Alephant::Renderer::Views::Html
    def content
      @data[:content]
    end
  end
end
