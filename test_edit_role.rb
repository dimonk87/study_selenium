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
    log_out
    sign_in
    create_project
    add_user
    edit_roles
    expected = "Developer, Reporter"
    @wait.until{@driver.find_element(:xpath, "//tr[2]/td[2]/span").displayed?}
    actual = @driver.find_element(:xpath, "//tr[2]/td[2]/span").text
    assert_equal(expected, actual)
  end

  def edit_roles
    @wait.until{@driver.find_element(:xpath, "//tr[2]/td[3]/a[1]").displayed?}
    @driver.find_element(:xpath, "//tr[2]/td[3]/a[1]").click
    @wait.until{@driver.find_element(:xpath, "(//input[@name='membership[role_ids][]'])[6]").displayed?}
    @driver.find_element(:xpath, "(//input[@name='membership[role_ids][]'])[6]").click
    @driver.find_element(:xpath, "(//input[@name='commit'])[4]").click
  end

  def teardown
    @driver.quit
  end
end