require "helpers/actions"

module Reducers
  R_AB = -> (state, action) {
    case action[:type]
    when :INITIALIZE
      { a: 0, b: 0 }
    when Actions::A_PLUS_ONE
      { a: state[:a]+1, b: state[:b] }
    when Actions::B_PLUS_ONE
      { a: state[:a], b: state[:b]+1 }
    else
      state
    end
  }

  R_CD = -> (state, action) {
    case action[:type]
    when :INITIALIZE
      { c: 0, d: 0 }
    when Actions::C_PLUS_ONE
      { c: state[:c]+1, d: state[:d] }
    when Actions::D_PLUS_ONE
      { c: state[:c], d: state[:d]+1 }
    else
      state
    end
  }

  R_EF = -> (state, action) {
    case action[:type]
    when :INITIALIZE
      { e: 0, f: 0 }
    when Actions::E_PLUS_ONE
      { e: state[:e]+1, f: state[:f] }
    when Actions::F_PLUS_ONE
      { e: state[:e], f: state[:f]+1 }
    else
      state
    end
  }

  R_GH = -> (state, action) {
    case action[:type]
    when :INITIALIZE
      { g: 0, h: 0 }
    when Actions::G_PLUS_ONE
      { g: state[:g]+1, h: state[:h] }
    when Actions::H_PLUS_ONE
      { g: state[:g], h: state[:h]+1 }
    else
      state
    end
  }
end