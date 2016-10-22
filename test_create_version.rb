require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestCreateVersion < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_create_version
    registration
    create_project
    create_version
    exp = "Successful creation."
    @wait.until{@driver.find_element(:id, "flash_notice").displayed?}
    act= @driver.find_element(:id, "flash_notice").text
    assert_equal(exp, act)
  end

  def create_version
    @wait.until{@driver.find_element(:id, 'tab-versions').displayed?}
    @driver.find_element(:id, 'tab-versions').click
    @driver.find_element(:link, "New version").click
    @wait.until{@driver.find_element(:id, "version_name").displayed?}
    name_new_version = ('Version' + rand(9999).to_s)
    @driver.find_element(:id, "version_name").send_keys name_new_version
    @driver.find_element(:id, "version_description").send_keys name_new_version
    @driver.find_element(:name, "commit").click
  end

  def teardown
    @driver.quit
  end
end