require 'test/unit'
require 'selenium-webdriver'
require_relative 'our_module'

class TestCreateIssue < Test::Unit::TestCase
  include OurModule
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end
  def test_ensure_visible_bag
    registration
    create_project
    bag_issue_create
    expected = "Bug"
    @wait.until{@driver.find_element(:css, 'div.contextual + h2').displayed?}
    actual = @driver.find_element(:css, 'div.contextual + h2').text[0..2]
    assert_equal(expected, actual)
  end

  def test_ensure_visible_feature
    sign_in
    create_project
    feature_create
    expected = "Feature"
    @wait.until{@driver.find_element(:css, 'div.contextual + h2').displayed?}
    actual = @driver.find_element(:css, 'div.contextual + h2').text[0..6]
    assert_equal(expected, actual)
  end

  def test_ensure_visible_support
    sign_in
    create_project
    support_create
    expected = "Support"
    @wait.until{@driver.find_element(:css, 'div.contextual + h2').displayed?}
    actual = @driver.find_element(:css, 'div.contextual + h2').text[0..6]
    assert_equal(expected, actual)
  end
  def create_issue
    @wait.until{@driver.find_element(:class, 'new-issue').displayed?}
    @driver.find_element(:class, 'new-issue').click
  end
  def bag_issue_create
    create_issue
    @wait.until{@driver.find_element(:id, 'issue_tracker_id').displayed?}
    dropdown = @driver.find_element(:id, 'issue_tracker_id')
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:text, "Bug")
    name_issue = ('Issue' + rand(9999).to_s)
    @driver.find_element(:id, 'issue_subject').send_keys name_issue
    @driver.find_element(:name, 'commit').click
  end
  def feature_create
    create_issue
    @wait.until{@driver.find_element(:id, 'issue_tracker_id').displayed?}
    dropdown = @driver.find_element(:id, 'issue_tracker_id')
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:text, "Feature")
    name_issue = ('Issue' + rand(9999).to_s)
    @driver.find_element(:id, 'issue_subject').send_keys name_issue
    @driver.find_element(:name, 'commit').click
  end
  def support_create
    create_issue
    @wait.until{@driver.find_element(:id, 'issue_tracker_id').displayed?}
    dropdown = @driver.find_element(:id, 'issue_tracker_id')
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:text, "Support")
    name_issue = ('Issue' + rand(9999).to_s)
    @driver.find_element(:id, 'issue_subject').send_keys name_issue
    @driver.find_element(:name, 'commit').click
  end

  def teardown
    @driver.quit
  end
end