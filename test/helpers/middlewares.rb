module Middlewares
  M1 = Rubidux::Middleware.create.(
    -> (_next, action, **middleware_api) {
      "In middleware 1"
      _next.(action)
      "Out middleware 1"
    }
  )

  M2 = Rubidux::Middleware.create.(
    -> (_next, action, **middleware_api) {
      "In middleware 2"
      _next.(action)
      "Out middleware 2"
    }
  )
end
