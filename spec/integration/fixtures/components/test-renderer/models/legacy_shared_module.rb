module MyApp
  class LegacySharedModule < Alephant::Renderer::Views::Html
    self.template_path = '/ignored/path/to/shared/templates'
    def module_type
      'legacy'
    end
  end
end
