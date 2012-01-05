Feature: Admin Manage users
  As an administrator of the website
  I want to modify other users

    Background: Create admin user and manage users
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      Given I am an admin named "foo" with a username "admin", an email "admin@test.com" and password "foobar"
      When I sign in as "admin/foobar"
      And I go to the manage_users page
      Then I should see "User Accounts"
      
    Scenario: Default user should not be enabled or approved
      Then "user" should not be approved
      And "user" should not be enabled        
    
    Scenario: I activate and enable a user
      Given admin activates "user"
      Then "user" should be approved
      And "user" should be enabled
      
    Scenario: Admin can disable a user but can never loose approved status
      Given admin activates "user"
      And I follow "Disable"
      Then I should see "User sucessfully Disabled"
      And "user" should not be enabled
      And "user" should be approved
      
    Scenario: Admin can enable a disabled user
      Given admin activates "user"
      And I follow "Disable"
      And I follow "Enable"
      Then I should see "User sucessfully Enabled"
      And "user" should be enabled
      And "user" should be approved
    
    Scenario: Admin can edit a user without password
      Given admin activates "user"
      And I follow "Edit"
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
      And I press "Save"
      Then I should see "User was successfully updated."
    
    Scenario: Admin can edit a user with password
      Given admin activates "user"
      And I follow "Edit"
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
        | user_password              | foobar1         |
        | user_password_confirmation | foobar1         |
      And I press "Save"
      Then I should see "User was successfully updated."
    
    Scenario: Admin can edit a user with incorrect specifications
      Given admin activates "user"
      And I follow "Edit"
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
        | user_password              | foobar1         |
        | user_password_confirmation |                 |
      And I press "Save"
      Then I should see "Some errors were found, please take a look:"
      
   Scenario: Admin can make another user an admin
      Given admin activates "user"
      And I follow "Edit"
      And I check "user_admin"
      And I press "Save"
      Then I should see "User was successfully updated."
      And "user" should be an admin
      
   Scenario: Disabled user cannot be an admin
      Given admin activates "user"
      And I follow "Edit"
      And I check "user_admin"
      And I uncheck "user_enabled"
      And I press "Save"
      Then "user" should be an admin
      And "user" should be enabled
      And I should not see "Account Enabled"


    Scenario: Admin can add a normal user manually
      Given I am on the users page
      And I follow "Create new user"
      And I fill in the following:
        | user_name                  | Mrs Testy McUserton |
        | user_username              | user1            |
        | user_email                 | user1@test.com   |
        | user_password              | foobar1         |
        | user_password_confirmation | foobar1         |
      And I press "Create"
      Then I should see "User was successfully created"

    Scenario: Admin can add an admin user manually
      Given I am on the users page
      And I follow "Create new user"
      And I fill in the following:
        | user_name                  | Mrs Testy McUserton |
        | user_username              | user1            |
        | user_email                 | user1@test.com   |
        | user_password              | foobar1         |
        | user_password_confirmation | foobar1         |
      And I check "user_admin"  
      And I press "Create"
      Then I should see "User was successfully created"

    Scenario: Admin can edit a user with incorrect specifications
      Given I am on the users page
      And I follow "Create new user"
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
        | user_password              | foobar1         |
        | user_password_confirmation |                 |
      And I press "Create"
      Then I should see "Some errors were found, please take a look:"
