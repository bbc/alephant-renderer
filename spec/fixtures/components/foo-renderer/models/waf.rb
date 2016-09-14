module MyApp
  class Waf < Alephant::Renderer::Views::Waf
        def head
          ['some/css/asset/path','some/js/asset/path']
        end

        def body_last
          ['some/thing/to/add/after/body', 'some/other/thing/to/add/after/body']
        end
  end
end
