module Rubidux
  class Store
    attr_reader :state
    attr_reader :dispatch
    attr_reader :subscribe
    attr_reader :listeners
    attr_accessor :reducer

    INITIALIZE = :INITIALIZE

    def initialize(reducer:, preloaded_state: {}, enhancer: nil)
      raise ArgumentError.new("Expect preloaded state to be a Hash.") unless preloaded_state.is_a? Hash
      raise ArgumentError.new("Expect reducer to be a Proc.") unless reducer.is_a? Proc
      raise ArgumentError.new("Expect enhancer to be a Proc.") unless (!enhancer || enhancer.is_a?(Proc))

      @state = {}
      @reducer = reducer
      @listeners = []
      @subscribe = _subscribe

      @dispatch = enhancer ? enhancer.(-> { @state }, _dispatch) : _dispatch
      @dispatch.({ type: INITIALIZE })

      @state = @state.merge preloaded_state
    end

    private

    attr_writer :state
    attr_writer :dispatch
    attr_writer :subscribe
    attr_writer :listeners

    def _dispatch
      -> action {
        raise ArgumentError.new("Expect action to have key 'type'.") unless action[:type]
        @state = @reducer.(@state, action)
        @listeners.each(&:call)
        action
      }
    end

    def _subscribe
      -> listener {
        raise ArgumentError.new("Expect listener to be a Proc.") unless listener.is_a? Proc
        @listeners.push listener
        -> { @listeners.delete listener }
      }
    end
  end
end
