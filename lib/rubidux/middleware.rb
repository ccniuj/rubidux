module Rubidux
  class Middleware
    def self.init(&block)
      -> (**middleware_api) {
        -> (_next) {
          -> (action) {
            block.call**middleware_api, action)
            _next(action)
          }
        }
      }
    end

    def self.apply_middleware(middlewares)
      -> (create_store) {
        -> (reducer, preload_state, enhancer) {
          store = create_store(reducer, preload_state, enhancer)
          middleware_api = {
            state: store.get_state,
            dispatch: -> (action) { store.dispatch(action) }
          }
          chain = middlewares.map { |middleware| middleware.(middleware_api) }
          store.dispatch = Util.compose(*chain)(store.dispatch)
          store
        }
      }
    end
  end
end
