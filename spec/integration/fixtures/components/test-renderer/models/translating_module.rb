module MyApp
  class TranslatingModule < Alephant::Renderer::Views::Html
    def module_type
      t 'module_type'
    end
  end
end
