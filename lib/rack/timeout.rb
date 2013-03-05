require RUBY_VERSION < '1.9' && RUBY_PLATFORM != 'java' ? 'system_timer' : 'timeout'
Timeout ||= SystemTimer

module Rack
  class Timeout
    @timeout = 15
    class << self
      attr_accessor :timeout
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      ::Timeout.timeout(self.class.timeout, ::Timeout::Error) { @app.call(env) }
    end

  end
end
