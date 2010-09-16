require File.expand_path("../helper", __FILE__)

class SpelingTest < Test::Unit::TestCase
  def sut(*args)
    Rack::Speling.new(*args)
  end

  def env
    { 'PATH_INFO' => '/somepath', 'REQUEST_URI' => '/somepath' }
  end

  def status_app(status)
    lambda { |env|
      [status, env, '']
    }
  end

  def echo_app
    lambda { |arg| return arg }
  end

  def test_downcasing_path_info
    result = sut(echo_app).call( env.merge('PATH_INFO' => '/SOMEPATH') )

    assert_equal env, result
  end

  def test_downcasing_request_uri
    result = sut(echo_app).call( env.merge('REQUEST_URI' => '/SOMEPATH') )
    assert_equal env, result
  end

  def test_does_not_touch_200s
    result = sut(status_app(200)).call(env)
    assert_equal 200, result[0], result.inspect
  end

  def test_does_accept_an_optional_lookup_object
    assert_nothing_raised do
      sut(echo_app)
      sut(echo_app, :lookup => {})
    end
  end

  def test_redirect_on_successful_lookup
    result = sut(status_app(404), :lookup => {
      '/somepath' => 'http://example.com/newpath'
    }).call(env)
    assert_equal 302, result[0]
    assert_equal 'http://example.com/newpath', result[1]['Location']
  end
end
