require 'test/unit'
require 'selenium-webdriver'

class TestRegistration < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_signup_negative
    register_user_without_submit
    expected_text = "Email cannot be blank
Login cannot be blank
First name cannot be blank
Last name cannot be blank
Password is too short (minimum is 4 characters)"
    actual_text = @driver.find_element(:id, 'errorExplanation').text
    assert_equal(expected_text, actual_text)
  end

  def register_user_without_submit
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until {@driver.find_element(:class, 'register').displayed?}
    @driver.find_element(:class, 'register').click
    @wait.until {@driver.find_element(:name, 'commit').displayed?}
    @driver.find_element(:name, 'commit').click
    @wait.until {@driver.find_element(:id, 'errorExplanation').displayed?}
  end

  def teardown
    @driver.quit
  end
end