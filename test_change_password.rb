require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestChangePassword < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @name = ('user' + rand(9999).to_s)
  end

  def test_change
    sign_up
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
    @wait.until {@driver.find_element(:xpath, '//a[@href="/my/password"]').displayed?}
    @driver.find_element(:xpath, '//a[@href="/my/password"]').click
    @wait.until {@driver.find_element(:id, 'password').displayed?}
    @driver.find_element(:id, 'password').send_keys @name
    @driver.find_element(:id, 'new_password').send_keys('aa123456')
    @driver.find_element(:id, 'new_password_confirmation').send_keys('aa123456')
    @driver.find_element(:name, 'commit').click
  end

  def sign_up
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until{@driver.find_element(:xpath, '//a[@href="/account/register"]').displayed?}
    puts @driver.find_element(:xpath, '//a[@href="/account/register"]').displayed?
    @driver.find_element(:xpath, '//a[@href="/account/register"]').click
    @wait.until{@driver.find_element(:id, 'user_login').displayed?}
    @driver.find_element(:id, 'user_login').send_keys @name
    @driver.find_element(:id, 'user_password').send_keys @name
    @driver.find_element(:id, 'user_password_confirmation').send_keys @name
    @driver.find_element(:id, 'user_firstname').send_keys @name
    @driver.find_element(:id, 'user_lastname').send_keys @name
    @driver.find_element(:id, 'user_mail').send_keys @name + "@i.ua"
    @driver.find_element(:name, 'commit').click
  end

  def teardown
    @driver.quit
  end
end