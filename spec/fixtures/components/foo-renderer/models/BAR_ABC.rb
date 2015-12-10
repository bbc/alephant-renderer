module MyApp
  class BarAbc < Alephant::Renderer::Views::Html
    def content
      @data[:content]
    end
  end
end
