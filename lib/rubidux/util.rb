module Rebidux
  class Util
    def self.compose(*funcs)
      if funcs.size == 1
        funcs[0] 
      else
        last = funcs[funcs.size-1]
        rest = funcs[0..funcs.size-2].reverse
        -> (*args) { rest.reduce(last.(*args)) { |composed, f| f.(composed) } }
      end
    end
  end
end
