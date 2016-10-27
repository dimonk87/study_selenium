require 'test/unit'
require 'selenium-webdriver'

class Probe < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end
  def logout1
    @wait.until{@driver.find_element(:css, 'div.uk-float-right ul.uk-dropdown-bottom a[rel=nofollow]')}
    sleep(2)
    @driver.find_element(:css, 'div.uk-float-right ul.uk-dropdown-bottom a[rel=nofollow]').click
  end
  def login1
    @driver.navigate.to 'http://localhost:3000/RoR'
    @wait.until{@driver.find_element(:id, 'test-email-sign_in').displayed?}
    @driver.find_element(:id, 'test-email-sign_in').send_keys "dimon.k87@gmail.com"
    @driver.find_element(:id, 'test-pass-sign_in').send_keys "aa123456"
    sleep(1)
    @driver.find_element(:css, 'input[name=commit]').click
  end
  def test_logaut
    login1
    logout1
  end
end