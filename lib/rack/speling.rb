# vim:ft=ruby:fileencoding=utf-8

module Rack
  class Speling
    attr_reader :app, :lookup, :env, :response

    # remember the application as we need to call before or after this
    # an lookup-object may be supplied for further 404-handling
    def initialize(app, options = {})
      @app = app
      @lookup = options[:lookup] || {}
    end

    # downcase PATH_INFO and REQUEST_URI
    # furthermore, try to lookup 404s to react with a redirect
    def call(env)
      @env = env

      downcase_path

      @response = app.call(env)

      if response[0] == 404 && path_lookup
        correct_response
      else
        response
      end
    end

    private

    def correct_response
      headers = response[1].merge({
        'Location' => new_location
      })

      [302, headers, "Moved: #{headers['Location']}"]
    end

    def new_location
      path_lookup.start_with?('http:') ? path_lookup : "http://#{env['HTTP_HOST']}#{path_lookup}"
    end

    def path_lookup
      @path_lookup ||= lookup[path]
    end

    def path
      env['PATH_INFO']
    end

    def downcase_path
      env['PATH_INFO']   = env['PATH_INFO'].downcase
      env['REQUEST_URI'] = env['REQUEST_URI'].downcase
    end
  end
end
