require 'test/unit'
require 'selenium-webdriver'

require_relative 'our_module'

class TestEditRole < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_edit_user_role
    reg_new_user
    registration
    create_project
    add_user
    edit_roles
    expected = "Developer, Reporter"
    @wait.until{@driver.find_element(:css, "tr.even td.roles span").displayed?}
    actual = @driver.find_element(:css, "tr.even td.roles span").text
    assert_equal(expected, actual)
  end

  def edit_roles
    @wait.until{@driver.find_element(:css, "tr.even a.icon-edit").displayed?}
    @driver.find_element(:css, "tr.even a.icon-edit").click
    @wait.until{@driver.find_element(:css, "tr.even label:nth-of-type(2)").displayed?}
    @driver.find_element(:css, "tr.even label:nth-of-type(2)").click
    @driver.find_element(:css, "tr.even input[name=commit]").click
  end

  def teardown
    @driver.quit
  end
end