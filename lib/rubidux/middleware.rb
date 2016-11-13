module Rubidux
  module Middleware
    def create
      -> fn {
        -> **middleware_api {
          -> _next {
            -> action {
              fn.(_next, action, **middleware_api)
            }
          }
        }
      }
    end

    def apply
      -> *middlewares {
        -> (get_state, dispatch) {
          middleware_api = {
            get_state: get_state,
            dispatch: -> action { new_dispatch.(action) }
          }
          chain = middlewares.map { |middleware| middleware.(middleware_api) }
          new_dispatch = Rebidux::Util.compose.(*chain).(dispatch)
        }
      }
    end

    module_function :create, :apply
  end
end
