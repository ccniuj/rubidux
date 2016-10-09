module Rubidux
  class Middleware
    def self.init(&block)
      -> (**middleware_api) {
        -> (_next) {
          -> (action) {
            block.call(action, **middleware_api)
            _next.(action)
          }
        }
      }
    end

    def self.apply_middleware(*middlewares)
      -> (state, dispatch) {
        middleware_api = {
          state: state,
          dispatch: -> (action) { dispatch.(action) }
        }
        chain = middlewares.map { |middleware| middleware.(middleware_api) }
        new_dispatch = Rebidux::Util.compose(*chain).(dispatch)
      }
    end
  end
end
