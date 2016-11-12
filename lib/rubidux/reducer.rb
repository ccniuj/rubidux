module Rubidux
  module Reducer
    def combine
      -> **reducers {
        -> (state, action) {
          state ||= {}
          reducers.
            lazy.
            select { |key, reducer| reducer.is_a? Proc }.
            map    { |key, reducer| [key, reducer.(state[key], action)] }.
            to_h
        }
      }
    end

    module_function :combine 
  end
end
