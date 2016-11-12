module Reducers
  R_AB = -> (state, action) {
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

  R_CD = -> (state, action) {
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

  R_EF = -> (state, action) {
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

  R_GH = -> (state, action) {
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