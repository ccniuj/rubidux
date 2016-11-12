require "test_helper"
require "helpers/reducers"
require "helpers/middlewares"
require "pry"

describe Rubidux::Middleware do
  describe "create" do
    it "returns a function currying 3 arguments" do
      m_layer_1 = Rubidux::Middleware.create.(
        -> (_next, action) { _next.(action) }
      )

      m_layer_2 = m_layer_1.()
      m_layer_3 = m_layer_2.(nil)

      m_layer_1.must_be_instance_of Proc
      m_layer_2.must_be_instance_of Proc
      m_layer_3.must_be_instance_of Proc
    end
  end

  describe "apply" do
    it "wraps dispatch function" do
      action = { type: "foo" }
      dispatch_mock = MiniTest::Mock.new
      1.times { dispatch_mock.expect :call, action, [action] }

      new_dispatch = Rubidux::Middleware.apply.(Middlewares::M1, Middlewares::M2).({}, dispatch_mock)
      new_dispatch.(action)

      dispatch_mock.verify
    end

    it "composes multiple middlewares" do
      action = { type: "foo", logs: [] }
      dispatch = -> action { action }
      log = -> (act, event) { act.merge({ logs: (act[:logs] + [event]) }) }

      m1 = Rubidux::Middleware.create.(
        -> (_next, action, **middleware_api) {
          new_action = log.(action, "m1_in")
          log.(_next.(new_action), "m1_out")
        }
      )

      m2 = Rubidux::Middleware.create.(
        -> (_next, action, **middleware_api) {
          new_action = log.(action, "m2_in")
          log.(_next.(new_action), "m2_out")
        }
      )

      new_dispatch = Rubidux::Middleware.apply.(m1, m2).({}, dispatch)
      new_dispatch.(action)[:logs].must_equal ["m1_in", "m2_in", "m2_out", "m1_out"]
    end
  end
end
