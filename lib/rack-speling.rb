# vim:ft=ruby:fileencoding=utf-8

module Rack
  module Speling
    # remember the application as we need to call it later on
    # (this is just a before-filter)
    def initialize(app)
      @app = app
    end

    # downcase PATH_INFO and REQUEST_URI
    def call(env)
      env['PATH_INFO']   = env['PATH_INFO'].downcase
      env['REQUEST_URI'] = env['REQUEST_URI'].downcase

      @app.call(env)
    end
  end
end
