require "test_helper"

describe Rubidux::Reducer do
  before do
    @r_ab = -> (state, action) {
      state ||= { a: 0, b: 0 }

      case action[:type]
      when 'a_plus_one'
        { a: state[:a]+1, b: state[:b] }
      when 'b_plus_one'
        { a: state[:a], b: state[:b]+1 }
      else
        state
      end
    }

    @r_cd = -> (state, action) {
      state ||= { c: 0, d: 0 }

      case action[:type]
      when 'c_plus_one'
        { c: state[:c]+1, d: state[:d] }
      when 'd_plus_one'
        { c: state[:c], d: state[:d]+1 }
      else
        state
      end
    }

    @r_ef = -> (state, action) {
      state ||= { e: 0, f: 0 }

      case action[:type]
      when 'e_plus_one'
        { e: state[:e]+1, f: state[:f] }
      when 'f_plus_one'
        { e: state[:e], f: state[:f]+1 }
      else
        state
      end
    }

    @r_gh = -> (state, action) {
      state ||= { g: 0, h: 0 }

      case action[:type]
      when 'g_plus_one'
        { g: state[:g]+1, h: state[:h] }
      when 'h_plus_one'
        { g: state[:g], h: state[:h]+1 }
      else
        state
      end
    }
  end

  describe "combine" do
    it "returns a composite reducer that maps the state keys to given reducers" do
      rc = Rubidux::Reducer.combine.(r1: @r_ab, r2: @r_cd)
      new_state = rc.({}, {})

      new_state.keys.must_equal [:r1, :r2]
    end

    it "returns a composite reducer of some other composite reducers" do
      rc1 = Rubidux::Reducer.combine.(r1: @r_ab, r2: @r_cd)
      rc2 = Rubidux::Reducer.combine.(r3: @r_ef, r4: @r_gh)
      rc = Rubidux::Reducer.combine.(rc1: rc1, rc2: rc2)
      new_state = rc.({}, {})

      new_state.keys.must_equal [:rc1, :rc2]
      new_state[:rc1].keys.must_equal [:r1, :r2]
      new_state[:rc2].keys.must_equal [:r3, :r4]
    end

    it "ignores all keys whose value are not a function" do
      rc = Rubidux::Reducer.combine.(r1: @r_ab, r2: "foo", r3: {foo: "bar"} )
      new_state = rc.({}, {})

      new_state.keys.must_equal [:r1]
    end
  end
end
