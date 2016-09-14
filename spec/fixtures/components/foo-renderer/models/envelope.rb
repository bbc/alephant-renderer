module MyApp
  class Envelope < Alephant::Renderer::Views::Envelope
    def head
      ['some/css/asset/path','some/js/asset/path']
    end

    def body_last
      ['some/thing/to/add/after/body', 'some/other/thing/to/add/after/body']
    end

    def greet
      @data[:foo]
    end
  end
end
