module OurModule
  def sign_in
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until {@driver.find_element(:class, 'login').displayed?}
    @driver.find_element(:class, 'login').click
    @wait.until {@driver.find_element(:id, 'username').displayed?}
    @driver.find_element(:id, 'username').send_keys('dimon.k87')
    @driver.find_element(:id, 'password').send_keys('aa123456789')
    @driver.find_element(:name, 'login').click
    @wait.until {@driver.find_element(:id, 'loggedas').displayed?}
  end

  def create_project
    @driver.find_element(:link_text, 'Projects').click
    @wait.until{@driver.find_element(:xpath, '/html/body/div/div/div[1]/div[3]/div[2]/div[1]/a[1]').displayed?}
    @driver.find_element(:css, 'a.icon.icon-add').click
    @wait.until{@driver.find_element(:id, 'project_name').displayed?}
    name_new_project = ('Project' + rand(9999).to_s)
    @driver.find_element(:id, 'project_name').send_keys name_new_project
    @driver.find_element(:id, 'project_description').send_keys "It's a study project"
    @driver.find_element(:id, 'project_description').send_keys name_new_project
    @driver.find_element(:name, 'commit').click
  end

  def add_user
    @wait.until{@driver.find_element(:id, 'flash_notice').displayed?}
    @driver.find_element(:id, 'tab-members').click
    @wait.until{@driver.find_element(:css, 'a.icon.icon-add').displayed?}
    @driver.find_element(:css, 'a.icon.icon-add').click
    @wait.until{@driver.find_element(:id, 'principal_search').displayed?}
    @driver.find_element(:id, 'principal_search').send_keys "Dimon"
    sleep(1)
    @driver.find_element(:name, "membership[user_ids][]").click
    @driver.find_element(:xpath, "(//input[@name='membership[role_ids][]'])[7]").click
    @driver.find_element(:id, "member-add-submit").click
  end
end