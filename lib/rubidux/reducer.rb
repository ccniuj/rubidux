module Rubidux
  class Reducer
    def self.combine(**reducers)
      -> (state, action) {
        state ||= {}
        reducers.
          lazy.
          select { |key, reducer| reducer.is_a? Proc }.
          map    { |key, reducer| [key, reducer.(state[key], action)] }.
          to_h
      }
    end
  end
end
