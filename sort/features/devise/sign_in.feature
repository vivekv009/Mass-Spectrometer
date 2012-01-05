Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: User is not signed up
      Given I am not logged in
      And no user exists with an username of "no_user"
      And I sign in as "no_user/foobar"
      Then I should see "Invalid username / password."
      And I go to the home page
      And I should be signed out

    Scenario: User enters wrong password
      Given I am not logged in
      And I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      When I go to the sign_in page
      And I sign in as "user@test.com/wrongpassword"
      Then I should see "Invalid username / password."
      And I go to the home page
      And I should be signed out

    Scenario: User signs in successfully with username
      Given I am not logged in
      And I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      And "user" is approved
      And "user" in enabled
      When I go to the sign_in page
      And I sign in as "user/foobar"
      Then I should see "Signed in successfully."
      And I should be signed in
      When I return next time
      Then I should be already signed in

