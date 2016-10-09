module Rubidux
  class Store
    attr_accessor :state
    attr_accessor :reducer
    attr_accessor :listeners
    attr_accessor :dispatch
    attr_accessor :subscribe

    def initialize(reducer, preload_state, enhancer = nil)
      raise ArgumentError.new("Expect reducer to be a Proc.") unless reducer.is_a? Proc
      @state = preload_state || {}
      @listeners = []
      @reducer = reducer
      @dispatch = _dispatch
      @subscribe = _subscribe

      @dispatch = enhancer.(-> { @state }, @dispatch) if enhancer
    end

    private

    def _dispatch
      -> (action) {
        raise ArgumentError.new("Expect action to have key 'type'.") unless action[:type]
        @state = @reducer.(@state, action)
        @listeners.each(&:call)
        action
      }
    end

    def _subscribe
      -> (listener) {
        raise ArgumentError.new("Expect listener to be a Proc.") unless listener.is_a? Proc
        @listeners.push listener
        -> { @listeners.delete listener }
      }
    end
  end
end
