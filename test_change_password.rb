require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestChangePassword < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_change
    registration
    change_password
    expected_message = "Password was successfully updated."
    @wait.until {@driver.find_element(:id, 'flash_notice').displayed?}
    actual_message = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_message, actual_message)
    assert('http://demo.redmine.org/my/account', @driver.current_url)
  end

  def change_password
    @wait.until {@driver.find_element(:class, 'my-account').displayed?}
    @driver.find_element(:class, 'my-account').click
    @wait.until {@driver.find_element(:css, 'a[href="/my/password"]').displayed?}
    @driver.find_element(:css, 'a[href="/my/password"]').click
    @wait.until {@driver.find_element(:id, 'password').displayed?}
    @driver.find_element(:id, 'password').send_keys @@name
    @driver.find_element(:id, 'new_password').send_keys('aa123456')
    @driver.find_element(:id, 'new_password_confirmation').send_keys('aa123456')
    @driver.find_element(:name, 'commit').click
  end

  def teardown
    @driver.quit
  end
end