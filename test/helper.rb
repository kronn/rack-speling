# vim:ft=ruby:fileencoding=utf-8

require 'test/unit/testcase'
require 'test/unit' unless defined?(Test::Unit)

base_path = ( File.expand_path(File.dirname(__FILE__)+'/..') )
lib_path  = "#{base_path}/lib"
if File.exist?(base_path + '/lib/rack-speling')
  $LOAD_PATH << base_path unless $LOAD_PATH.include?(base_path)
end
if File.exist?( lib_path )
  $LOAD_PATH << lib_path unless $LOAD_PATH.include?(lib_path)
end

require 'rack-speling'
