Feature: Visit the help page
  As a user
  I visit the help pages
  
  Background:
    Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
    Given "user" is approved
    Given "user" in enabled
    When I sign in as "user/foobar"

  Scenario: Visit index
    Given I visit help index