require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestAddUserInProject < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_add_user
    reg_new_user
    registration
    log_out
    sign_in
    create_project
    add_user
    expected_string = @@user_new_name
    @wait.until{@driver.find_element(:xpath, '//tr[2]/td[1]/a').displayed?}
    actual_string = @driver.find_element(:xpath, '//tr[2]/td[1]/a').text
    assert_equal(expected_string, actual_string)
  end

  def teardown
    @driver.quit
  end
end