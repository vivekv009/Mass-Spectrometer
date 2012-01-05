Given /^no user exists with an username of "(.*)"$/ do |username|
  User.find(:first, :conditions => { :username => username }).should be_nil
end

Given /^I am a user named "([^"]*)" with a username "([^"]*)", an email "([^"]*)" and password "([^"]*)"$/ do |name, username, email, password|
  User.new(:name => name,
            :username => username,
            :email => email,
            :password => password,
            :password_confirmation => password
            ).save!
end

Given /^"([^"]*)" is approved$/ do |username|
  @user = User.find(:first, :conditions => { :username => username })
  @user.approved = true
  @user.save
end

Given /^"([^"]*)" in enabled$/ do |username|
  @user = User.find(:first, :conditions => { :username => username })
  @user.enabled = true
  @user.save
end


Given /^I am an admin named "([^"]*)" with a username "([^"]*)", an email "([^"]*)" and password "([^"]*)"$/ do |name, username, email, password|
  User.new(:name => name,
            :username => username,
            :email => email,
            :password => password,
            :password_confirmation => password,
            :approved => true,
            :admin => true,
            :enabled => true
            ).save!
end

Then /^I should be already signed in$/ do
  step %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  step %{I am not logged in}
  step %{I go to the sign up page}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  step %{I press "Sign up"}
  step %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  step %{I am logout}
end

Given /^admin activates "([^"]*)"$/ do |arg1|
  # TODO better test
  step %{I follow "Activate"}
end

Then /^"([^"]*)" should be approved$/ do |username|
  User.find(:first, :conditions => { :username => username, :approved => true }).should_not be_nil
end

Then /^"([^"]*)" should be an admin$/ do |username|
  User.find(:first, :conditions => { :username => username, :admin => true }).should_not be_nil
end

Then /^"([^"]*)" should not be approved$/ do |username|
  User.find(:first, :conditions => { :username => username, :approved => true }).should be_nil
end

Then /^"([^"]*)" should be enabled$/ do |username|
  User.find(:first, :conditions => { :username => username, :enabled => true }).should_not be_nil
end

Then /^"([^"]*)" should not be enabled$/ do |username|
  User.find(:first, :conditions => { :username => username, :enabled => true }).should be_nil
end

Given /^I am logout$/ do
  step %{I sign out}
end

Given /^I am not logged in$/ do
  step %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |username, password|
  step %{I am not logged in}
  step %{I go to the sign_in page}
  step %{I fill in "user_username" with "#{username}"}
  step %{I fill in "user_password" with "#{password}"}
  step %{I press "Sign in"}
  @current_user = User.where(:username => username).first
end

Then /^I should be signed in$/ do
  step %{I should see "Signed in successfully."}
end

When /^I return next time$/ do
  step %{I go to the home page}
end

Then /^I should be signed out$/ do
  step %{I should see "Sign up"}
  step %{I should see "Please login to your @OMSSA account to continue"}
  step %{I should not see "Logout"}
end

Then /^I sign out$/ do
  visit destroy_user_session_path
end
