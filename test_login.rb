require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestLogin < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_logaut_and_login_positive
    registration
    log_out
    @wait.until{@driver.find_element(:xpath, '//a[@href="/login"]').displayed?}
    expect_link_text = "Sign in"
    actual_link_text = @driver.find_element(:xpath, '//a[@href="/login"]').text
    assert_equal(expect_link_text, actual_link_text)
    assert('http://demo.redmine.org', @driver.current_url)
    sign_in
    expected_text = "Logged in as " + @@name
    @wait.until{@driver.find_element(:id, 'loggedas').displayed?}
    actual_text = @driver.find_element(:id, 'loggedas').text
    assert_equal(expected_text, actual_text)
  end

  def teardown
    @driver.quit
  end
end