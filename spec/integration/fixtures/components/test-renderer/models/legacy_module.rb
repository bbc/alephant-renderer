module MyApp
  class LegacyModule < Alephant::Renderer::Views::Html
    self.template_path = '/ignored/path/to/templates'
    def module_type
      'legacy'
    end
  end
end
