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
    find_bug_feature_support
    expected = "Bug"
    @wait.until{@driver.find_element(:css, "td.tracker").displayed?}
    actual = @driver.find_element(:css, "td.tracker").text
    assert_equal(expected, actual)
  end

  def test_ensure_visible_feature
    sign_in
    create_project
    feature_create
    find_bug_feature_support
    expected = "Feature"
    @wait.until{@driver.find_element(:css, "td.tracker").displayed?}
    actual = @driver.find_element(:css, "td.tracker").text
    assert_equal(expected, actual)
  end

  def test_ensure_visible_support
    sign_in
    create_project
    support_create
    find_bug_feature_support
    expected = "Support"
    @wait.until{@driver.find_element(:css, "td.tracker").displayed?}
    actual = @driver.find_element(:css, "td.tracker").text
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
  def find_bug_feature_support
    @wait.until{@driver.find_element(:css, "div#sidebar li:nth-of-type(1) a").displayed?}
    puts @driver.find_element(:css, "div#sidebar li:nth-of-type(1) a").displayed?
    @driver.find_element(:css, "div#sidebar li:nth-of-type(1) a").click
  end
  def teardown
    @driver.quit
  end
end