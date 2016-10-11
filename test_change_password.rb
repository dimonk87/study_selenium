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
    sign_in
    change_password
    expected_message = "Password was successfully updated."
    @wait.until {@driver.find_element(:id, 'flash_notice').displayed?}
    actual_message = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_message, actual_message)
    rechange_password
    assert('http://demo.redmine.org/my/account', @driver.current_url)
  end

  def change_password
    @wait.until {@driver.find_element(:link_text, 'My account').displayed?}
    @driver.find_element(:link_text, 'My account').click
    @wait.until {@driver.find_element(:link_text, 'Change password').displayed?}
    @driver.find_element(:link_text, 'Change password').click
    @wait.until {@driver.find_element(:id, 'password').displayed?}
    @driver.find_element(:id, 'password').send_keys('aa123456789')
    @driver.find_element(:id, 'new_password').send_keys('aa123456')
    @driver.find_element(:id, 'new_password_confirmation').send_keys('aa123456')
    @driver.find_element(:name, 'commit').click
  end

  def rechange_password
    @wait.until {@driver.find_element(:link_text, 'Change password').displayed?}
    @driver.find_element(:link_text, 'Change password').click
    @wait.until {@driver.find_element(:id, 'password').displayed?}
    @driver.find_element(:id, 'password').send_keys('aa123456')
    @driver.find_element(:id, 'new_password').send_keys('aa123456789')
    @driver.find_element(:id, 'new_password_confirmation').send_keys('aa123456789')
    @driver.find_element(:name, 'commit').click
  end

  def teardown
    @driver.quit
  end
end