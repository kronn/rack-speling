#!/usr/bin/env rake
# vim:ft=ruby:fileencoding=utf-8

# # enable trace to get better error output
# Rake.application.options.trace = true

# # documentation tasks
# begin
#   %w[ rake/rdoctask sdoc ].each { |lib| require lib }
#   Rake::RDocTask.new do |rdoc|
#     version = File.exist?('VERSION') ? File.read('VERSION') : ""
#
#     rdoc.rdoc_dir = 'doc/rdoc'
#     rdoc.title = "to_pass #{version}"
#     rdoc.options << '--fmt=shtml'
#     rdoc.options << '--all'
#     rdoc.options << '--charset=utf-8'
#     rdoc.template = 'direct'
#     rdoc.rdoc_files.include('README*')
#     rdoc.rdoc_files.include('LICENSE')
#     rdoc.rdoc_files.include('TODO')
#     rdoc.rdoc_files.include('lib/**/*.rb')
#     rdoc.rdoc_files.include('data/**/*.rb')
#   end
# rescue LoadError
# end

desc "run tests"
task :test do
  # optional libraries
  %w[ redgreen ].each do |lib|
    begin
      require lib
    rescue LoadError
    end
  end

  require 'test/unit'

  ( ['test/helper'] + Dir['test/test_*.rb'] ).each do |file|
    require File.expand_path("../#{file}", __FILE__)
  end
end

task :default => :test
