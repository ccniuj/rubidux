require "test_helper"
require "helpers/reducers"

describe Rubidux::Reducer do
  describe "combine" do
    it "returns a composite reducer that maps the state keys to given reducers" do
      rc = Rubidux::Reducer.combine.(r1: Reducers::R_AB, r2: Reducers::R_CD)
      new_state = rc.({}, {})

      new_state.keys.must_equal [:r1, :r2]
    end

    it "returns a composite reducer of some other composite reducers" do
      rc1 = Rubidux::Reducer.combine.(r1: Reducers::R_AB, r2: Reducers::R_CD)
      rc2 = Rubidux::Reducer.combine.(r3: Reducers::R_EF, r4: Reducers::R_GH)
      rc = Rubidux::Reducer.combine.(rc1: rc1, rc2: rc2)
      new_state = rc.({}, {})

      new_state.keys.must_equal [:rc1, :rc2]
      new_state[:rc1].keys.must_equal [:r1, :r2]
      new_state[:rc2].keys.must_equal [:r3, :r4]
    end

    it "ignores all keys whose value are not a function" do
      rc = Rubidux::Reducer.combine.(r1: Reducers::R_AB, r2: "foo", r3: {foo: "bar"} )
      new_state = rc.({}, {})

      new_state.keys.must_equal [:r1]
    end
  end
end
