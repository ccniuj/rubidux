module Rubidux
  class Reducer
    def self.combine_reducers(**reducers)
      -> (state, action) {
        state = {} unless state
        Hash[reducers.map { |key, reducer| [key, reducer.(state[key], action)] }]
      }
    end
  end
end
