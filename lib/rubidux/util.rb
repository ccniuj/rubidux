module Rebidux
  module Util
    def compose
      -> *funcs {
        if funcs.size == 1
          funcs[0]
        else
          -> init { funcs.reverse.reduce(init) { |composed, f| f.(composed) } }
        end
      }
    end

    module_function :compose
  end
end
