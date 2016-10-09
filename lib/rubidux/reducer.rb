module Rubidux
  class Reducer
    def self.combine(**reducers)
      -> (state, action) {
        state ||= {}
        Hash[reducers.map { |key, reducer| [key, reducer.(state[key], action)] }]
      }
    end
  end
end
