Given /^(\d+) database(?:s?) exist(?:s?) with (\d+) version(?:s?) by "(\w+)"$/ do |databases, versions, username|
  user = User.where(:username => username).first
  databases.to_i.times { |i| 
    database = FactoryGirl.create :database, :user => user
    versions.to_i.times { |j| 
      FactoryGirl.create :database_version, :database => database, :processed => true, :enabled => true
    }
  }
end


Given /^(\d+) enabled database(?:s?) exist(?:s?) along (\d+) enabled version(?:s?)$/ do |db, v|  
 
   file = Rack::Test::UploadedFile.new("features/sequence_library/valid_database.fasta", 'fasta/plain')
   user = User.new(:name => "foo",
            :username => "user",
            :email => "user@test.com",
            :password => "foobar",
            :password_confirmation => "foobar",
            :approved => true,
            :admin => false,
            :enabled => true
            )
  db.to_i.times { |i| 
    database = FactoryGirl.create :database, :title => "db_"+"#{i+1}", :user => user, :enabled => "true"
    v.to_i.times { |j| 
      FactoryGirl.create :database_version, :enabled => "true", :database_title => "valid_database.fasta", :database => database, :file => file, :processed => true,
      :created_at => "2012-03-10 18:31:"+"#{j}", :database_id => database.id
    }
  }
end 

Given /^(\d+) database(?:s?) exist(?:s?)$/ do |databases|
  databases.to_i.times { |i| FactoryGirl.create :database_version}
end

Given /^(\d+) database(?:s?) exist(?:s?) with (\d+) versions$/ do |databases, versions|
  databases.to_i.times { |i| 
    database = FactoryGirl.create :database
    versions.to_i.times { |j| 
      FactoryGirl.create :database_version, :id => j, :database_id => database.id,  :processed => true
    }
  }
end

Given /^(\d+) database(?:s?) exist(?:s?) with (\d+) differnt version states$/ do |databases, versions|
  databases.to_i.times { |i| 
    database = FactoryGirl.create :database
    versions.to_i.times { |j| 
      case j
      when 1
        FactoryGirl.create :database_version, :id => j, :database_id => database.id,  :processed => false
      when 2
        FactoryGirl.create :database_version, :id => j, :database_id => database.id,  :processed => true, :error_message => "Error " + j.to_s
      else
        FactoryGirl.create :database_version, :id => j, :database_id => database.id,  :processed => true
      end
    }
  }
end

Given /^I create a database$/ do 
  click_link "New Database" 
  fill_in('database_title', :with => "database_1")
  #click_button("Browse") 
  click_button("Create Database")
end

Given /^I create a duplicate database$/ do 
  steps <<-STEP
    Given I am on the databases page
    And I follow "New Database"
    And I fill in "Title" with "database_1"
    And I press "Create Database"
    Then I should see "not successfully "
  STEP
end

Given /^I edit the database name$/ do
  steps <<-STEP
    Given I am on the databases page
    And I follow "Edit" 
    And I fill in "Title" with "database_1"
    And I press "Edit Database" 
  STEP
end

Given /^I update a database with a another version$/ do
  steps <<-STEP	
    And I follow "Update"
    And I press "Update Database"
  STEP
end

Given /^I upload a database version with a different name$/ do
  steps <<-STEP
    Given I am on the databases page
    And I follow "Update"	
    And I press "Update Database"	
  STEP
end 

Given /^I do not upload a database version$/ do
  steps <<-STEP
    Given I am on the databases page
    And I follow "Update"
    And I press "Update Database" 
  STEP
end

Then /^the database versions are displayed$/ do
  page.should have_content("database_1")
  page.should have_content("valid_database.fasta")
  page.should have_content("valid_database2.fasta")
end

Given /^I request database (\d+)s versions$/ do |id|
  visit("databases/" + id + "/versions")
  json = JSON.parse(page.source)
  json.length.should == 4
end

Given /^I show it under disabled databases$/ do 
  click_link("Disabled Database")
end 

Given /^I show database number (\d+) versions$/ do |id|
  visit("databases/" + id)
end


Given /^I show database version (\d+)$/ do |id|
  click_link("show_" + id)
end


Then /^I should see database was successfully added$/ do
	page.should have_content("successfully")
end
  
Then /^the database is added to the list$/ do
  page.should have_content("valid_database.fasta")
end

Then /^a new version of the database is added to the list$/ do
  page.should have_content("valid_database.fasta")
end

Then /^I should see database was not successfully added$/ do
  page.should_not have_content("successfully")
end

Then /^I should see database name was successfully updated$/ do
	page.should have_content("Database name was successfully updated")
end


#Given /^(\d+) database(?:s?) exist(?:s?) with (\d+) versions$/ do |databases, versions|
#  databases.to_i.times { |i| 
#    database = FactoryGirl.create :database
#    versions.to_i.times { |j| 
#      FactoryGirl.create :database_version, :database => database, :processed => true, :enabled => true
#    }
#  }
#end

Given /^I disable the database version number (\d+)$/ do |id|
  visit("/database_versions/" + id + "/disable")
end

Given /^I enable the database version number (\d+)$/ do |id|
  visit("/database_versions/" + id + "/enable")
end

 Given /^I disable database number (\d+)$/ do |id|
   visit("/databases/" + id + "/disableall")
 end
 
 
 Given /^I enable database number (\d+)$/ do |id|
   visit("/databases/" + id + "/enableall")
 end

 Then /^I should see "(\d+)" "(\w+)" database version(?:s?)$/ do |num, state|
   #find a table within the .active/.disabled divs of the tab-content.
   #Then count the rows and check it gives the desired amount, minus the header
   # E.G> Then I should see "5" "active" database versions
   # E.G> Then I should see "1" "disabled" database version
    find(".tab-content").find(".#{state}").all('table tr').count.should == num.to_i+1
 end

Then /^I should see database version (\d+)$/ do |id|
  dv = DatabaseVersion.find(id)
  page.should have_content(dv.database.title + " version: " + dv.database.created_at.to_s)
end


Then /^I should see all databases$/ do 
 page.should have_content("db_1")
 page.should have_content("db_2")
end 

Then /^I should see the (\d+) "([^"]*)" status$/ do |number, status|
 regexp = Regexp.new(status)
 page.find(:xpath, '//body').text.split(regexp).length.should == (number.to_i + 1)
end

