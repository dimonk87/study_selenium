require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestLogin < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_login_positive
    sign_in
    expected_text = "Logged in as dimon.k87"
    actual_text = @driver.find_element(:id, 'loggedas').text
    assert_equal(expected_text, actual_text)
  end

  def log_out
    @driver.find_element(:class, 'logout').click
    @wait.until {@driver.find_element(:class, 'login').displayed?}
  end

  def test_logaut_positive
    test_login_positive
    log_out
    expect_link_text = "Sign in"
    actual_link_text = @driver.find_element(:class, 'login').text
    assert_equal(expect_link_text, actual_link_text)
    assert('http://demo.redmine.org', @driver.current_url)
  end

  def teardown
    @driver.quit
  end
end