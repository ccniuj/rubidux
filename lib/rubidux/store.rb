module Rubidux
  class Store
    attr_accessor :state
    attr_accessor :reducer
    attr_accessor :listeners
    attr_accessor :dispatch
    attr_accessor :subscribe

    def initialize(reducer, preload_state, enhancer)
      raise "Expect reducer to be a Proc." if reducer.class.to_s != 'Proc'
      enhancer(Rebidux::Store)(reducer, preload_state) if enhancer
      @state = preload_state || {}
      @listeners = []
      @reducer = reducer
      @dispatch = _dispatch
      @subscribe = _subscribe
    end

    private

    def _dispatch
      -> (action) {
        raise "Expect action to have key 'type'." if action['type'].nil?
        @state = reducer(@state, action)
        @listeners.each(&:call)
        action
      }
    end

    def _subscribe
      -> (listener) {
        raise "Expect listener to be a proc." if listener.class.to_s != 'Proc'
        @listeners.push listener
        -> { @listeners.delete listener }
      }
    end
  end
end
