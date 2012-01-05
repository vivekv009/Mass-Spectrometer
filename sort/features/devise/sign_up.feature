Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in
      And I am on the home page
      And I go to the sign_up page

    Scenario: User signs up with valid data
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
        | user_password              | foobar          |
        | user_password_confirmation | foobar          |
      And I press "Sign up"
      When I sign in as "user/foobar"
      Then I should see "Your account needs to be activated by the administrator before you can login, You will receive an email when an Admin approves your account." 
      
    Scenario: User signs up with invalid email
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | invalidemail    |
        | user_password              | foobar          |
        | user_password_confirmation | foobar          |
      And I press "Sign up"
      Then I should see "Email is invalid"

    Scenario: User signs up without password
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
        | user_password              |                 |
        | user_password_confirmation | foobar          |
      And I press "Sign up"
      Then I should see "Password can't be blank"

    Scenario: User signs up without password confirmation
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
        | user_password              | foobar          |
        | user_password_confirmation |                 |
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"

    Scenario: User signs up with mismatched password and confirmation
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_username              | user            |
        | user_email                 | user@test.com   |
        | user_password              | foobar          |
        | user_password_confirmation | foobar1         |
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"


