Feature: Harddisk Space
  As a user I'd like to be notified about low hard drive space so that I know that I need to free up space

    Background:
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      Given "user" is approved
      Given "user" in enabled
      When I sign in as "user/foobar"

    Scenario: Hard Disk Space is ok on new submission
      Given hard disk space is high
      And I am on the new_submission page
      Then I should not see "Low disk space!"

    Scenario: Hard Disk Space is ok on new database
      Given hard disk space is high
      And I am on the new_database page
      Then I should not see "Low disk space!"

    Scenario: Hard Disk Space is low on new submission
      Given hard disk space is low
      And I am on the new_submission page
      Then I should see "Low disk space!"

    Scenario: Hard Disk Space is low on new database
      Given hard disk space is low
      And I am on the new_database page
      Then I should see "Low disk space!"
