def combine_reducers(reducers)
  (state, action) -> {
    Hash[reducers.map { |key, reducer| [key, recuder(state[key], action)] }]
  }
end
