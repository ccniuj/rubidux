require "test_helper"
require "helpers/reducers"
require "helpers/middlewares"
require "helpers/actions"

describe Rubidux::Store do
  describe "new" do
    it "exposes the public API" do
      store = Rubidux::Store.new(reducer: Reducers::R_AB)
      store.methods.must_include :state
      store.methods.must_include :dispatch
      store.methods.must_include :subscribe
      store.methods.must_include :reducer
      store.methods.must_include :reducer=
    end

    it "hides the private API" do
      store = Rubidux::Store.new(reducer: Reducers::R_AB)
      store.methods.wont_include :state=
      store.methods.wont_include :dispatch=
      store.methods.wont_include :subscribe=
    end

    it "raises an argument error if preloaded state is not a hash" do
      -> { Rubidux::Store.new(reducer: Reducers::R_AB, preloaded_state: "foo") }.must_raise ArgumentError
    end

    it "raises an argument error if reducer is not a function" do
      -> { Rubidux::Store.new(reducer: { foo: "bar" }) }.must_raise ArgumentError
    end

    it "raises an argument error if enhancer is not a function" do
      -> { Rubidux::Store.new(reducer: Reducers::R_AB, enhancer: "foo") }.must_raise ArgumentError
    end

    it "initializes state tree" do
      store = Rubidux::Store.new(reducer: Reducers::R_AB)
      store.state.must_equal({ a: 0, b: 0 })
    end

    it "assigns the preloaded state" do
      state = { a: 1, b: 0, c: 2 }
      store = Rubidux::Store.new(reducer: Reducers::R_AB, preloaded_state: state)
      store.state.must_equal state
    end
  end

  describe "dispatch" do
    it "applies the reducer to the previous state" do
      action = { type: Actions::A_PLUS_ONE }
      store = Rubidux::Store.new(reducer: Reducers::R_AB)
      store.dispatch.(action)
      store.state.must_equal({ a: 1, b: 0 })
    end

    it "is enhanced if a valid enhancer is given" do
      dispatch_mock = Minitest::Mock.new
      dispatch_mock.expect :call, {}, [Hash]

      enhancer_mock = Minitest::Mock.new
      enhancer_mock.expect :!, false
      enhancer_mock.expect :is_a?, true, [Proc]
      enhancer_mock.expect :call, dispatch_mock, [Proc, Proc]

      store = Rubidux::Store.new(reducer: Reducers::R_AB, enhancer: enhancer_mock)

      enhancer_mock.verify
    end
  end
end
