module OurModule

  @@name = ('User' + rand(9999).to_s)
  @@name1 = ('User' + rand(9999).to_s)
  @@user_new_name = @@name1 + ' ' + @@name1

  def create_project
    @wait.until{@driver.find_element(:class, 'projects').displayed?}
    puts @driver.find_element(:class, 'projects').displayed?
    @driver.find_element(:class, 'projects').click
    @wait.until{@driver.find_element(:xpath, "//a[@href='/projects/new']").displayed?}
    puts @driver.find_element(:xpath, "//a[@href='/projects/new']").displayed?
    @driver.find_element(:xpath, "//a[@href='/projects/new']").click
    @wait.until{@driver.find_element(:id, 'project_name').displayed?}
    name_new_project = ('Project' + rand(9999).to_s)
    @driver.find_element(:id, 'project_name').send_keys name_new_project
    @driver.find_element(:id, 'project_description').send_keys "It's a study project"
    @driver.find_element(:id, 'project_description').send_keys name_new_project
    @wait.until{@driver.find_element(:name, 'commit').displayed?}
    @driver.find_element(:name, 'commit').click
  end

  def add_user
    @wait.until{@driver.find_element(:id, 'flash_notice').displayed?}
    @driver.find_element(:id, 'tab-members').click
    @wait.until{@driver.find_element(:css, 'a.icon.icon-add').displayed?}
    @driver.find_element(:css, 'a.icon.icon-add').click
    @wait.until{@driver.find_element(:id, 'principal_search').displayed?}
    @driver.find_element(:id, 'principal_search').send_keys @@user_new_name
    sleep(1)
    @driver.find_element(:name, "membership[user_ids][]").click
    @driver.find_element(:xpath, "(//input[@name='membership[role_ids][]'])[7]").click
    @driver.find_element(:id, "member-add-submit").click
  end

  def registration
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until{@driver.find_element(:xpath, '//a[@href="/account/register"]').displayed?}
    @driver.find_element(:xpath, '//a[@href="/account/register"]').click
    @wait.until{@driver.find_element(:id, 'user_login').displayed?}
    @driver.find_element(:id, 'user_login').send_keys @@name
    @driver.find_element(:id, 'user_password').send_keys @@name
    @driver.find_element(:id, 'user_password_confirmation').send_keys @@name
    @driver.find_element(:id, 'user_firstname').send_keys @@name
    @driver.find_element(:id, 'user_lastname').send_keys @@name
    @driver.find_element(:id, 'user_mail').send_keys @@name + "@i.ua"
    @driver.find_element(:name, 'commit').click
    @wait.until{@driver.find_element(:class, "logout").displayed?}
  end

  def sign_in
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until{@driver.find_element(:xpath, '//a[@href="/login"]').displayed?}
    puts @driver.find_element(:xpath, '//a[@href="/login"]').displayed?
    @driver.find_element(:xpath, '//a[@href="/login"]').click
    @wait.until{@driver.find_element(:id, 'username').displayed?}
    @driver.find_element(:id, 'username').send_keys @@name
    @driver.find_element(:id, 'password').send_keys @@name
    @wait.until{@driver.find_element(:name, 'login').displayed?}
    puts @driver.find_element(:name, 'login').displayed?
    @driver.find_element(:name, 'login').click
    @wait.until{@driver.find_element(:class, 'projects').displayed?}
  end

  def log_out
    @wait.until{@driver.find_element(:xpath, '//a[@href="/logout"]').displayed?}
    puts @driver.find_element(:xpath, '//a[@href="/logout"]').displayed?
    @driver.find_element(:xpath, '//a[@href="/logout"]').click
    @wait.until{@driver.find_element(:class, 'login').displayed?}
  end

  def reg_new_user
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until{@driver.find_element(:xpath, '//a[@href="/account/register"]').displayed?}
    @driver.find_element(:xpath, '//a[@href="/account/register"]').click
    @wait.until{@driver.find_element(:id, 'user_login').displayed?}
    @driver.find_element(:id, 'user_login').send_keys @@name1
    @driver.find_element(:id, 'user_password').send_keys @@name1
    @driver.find_element(:id, 'user_password_confirmation').send_keys @@name1
    @driver.find_element(:id, 'user_firstname').send_keys @@name1
    @driver.find_element(:id, 'user_lastname').send_keys @@name1
    @driver.find_element(:id, 'user_mail').send_keys @@name1 + "@i.ua"
    @driver.find_element(:name, 'commit').click
    @wait.until{@driver.find_element(:class, "logout").displayed?}
    log_out
  end

end