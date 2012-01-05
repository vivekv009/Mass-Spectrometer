Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  so I can change my Name

    Scenario: I sign in and edit my account
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      And "user" is approved
      And "user" in enabled
      When I sign in as "user/foobar"
      Then I should be signed in
      When I follow "My Account"
      And I fill in "user_name" with "My New Name"
      And I fill in "user_current_password" with "foobar"
      And I press "Save"
      And I go to the homepage
      Then I should see "My New Name"

