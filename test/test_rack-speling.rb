require File.expand_path("../helper", __FILE__)

class SpelingTest < Test::Unit::TestCase
  def sut
    speling = Class.new do
      include Rack::Speling
    end
    app = lambda { |arg| return arg }

    speling.new(app)
  end

  def env
    { 'PATH_INFO' => '/somepath', 'REQUEST_URI' => '/somepath' }
  end

  def test_downcasing_path_info
    result = sut.call( env.merge('PATH_INFO' => '/SOMEPATH') )

    assert_equal env, result
  end

  def test_downcasing_request_uri
    result = sut.call( env.merge('REQUEST_URI' => '/SOMEPATH') )
    assert_equal env, result
  end
end
