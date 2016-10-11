require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestCreateProject < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_new_project
    sign_in
    create_project
    expected_message = "Successful creation."
    @wait.until{@driver.find_element(:id, 'flash_notice').displayed?}
    actual = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_message, actual)
  end

  def teardown
    @driver.quit
  end
end