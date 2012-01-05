Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      Given "user" is approved
      Given "user" in enabled
      When I sign in as "user/foobar"
      Then I should be signed in
      And I sign out
      Then I should be signed out
      When I return next time
      Then I should be signed out

