# vim:ft=ruby:fileencoding=utf-8
require './lib/rack/speling/version.rb'

spec = Gem::Specification.new do |s|
  s.name = 'rack-speling'
  s.version = Rack::Speling::VERSION

  s.authors = ["Matthias Viehweger"]
  s.email = ['kronn@kronn.de']
  s.homepage = 'http://github.com/kronn/rack-speling'
  s.rubyforge_project = '[none]' # to supress the warning

  s.summary = Rack::Speling::SUMMARY
  s.description = Rack::Speling::DESCRIPTION

  s.platform    = Gem::Platform::RUBY
  s.required_rubygems_version = ">= 1.3.5"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files test`.split("\n")
  s.require_path = 'lib'
end
