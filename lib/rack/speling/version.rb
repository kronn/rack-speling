# vim:ft=ruby:fileencoding=utf-8

module Rack # :nodoc:
  module Speling
    VERSION = "0.1.0"

    SUMMARY = "Simple Speling corretor in Rack"

    DESCRIPTION = <<-EOD
      Rack::Speling is a simple port of mod_speling to Rack.

      Currently, only case-insensitivety is achieved. Custom
      correction-code can be passed into the middleware.
    EOD
  end
end
