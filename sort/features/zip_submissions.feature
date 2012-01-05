Feature: Zip Submissions
  As a user
  I can add multiple submissions in a zip file.
  
	Background:
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      Given "user" is approved
      Given "user" in enabled
      When I sign in as "user/foobar"

    Scenario: Add multiple submissions with zip
      Given 1 database exists
      Given I am on the new_submission page
      Given I fill in valid submission parameters
      Given I select a zip file
      Given I submit the form
      Then I should see "successfully"

    Scenario: Add multiple submissions with empty zip
      Given 1 database exists
      Given I am on the new_submission page
      Given I fill in valid submission parameters
      Given I select an empty zip file
      Given I submit the form
      Then I should see errors

    Scenario: Add multiple submissions with invalid zip
        Given 1 database exists
        Given I am on the new_submission page
        Given I fill in valid submission parameters
        Given I select an invalid zip file
        Given I submit the form
        Then I should see errors

    Scenario: Add Empty Submission to the queue with zip
      Given I am on the new_submission page
      And I select a zip file
      And I submit the form
      Then I should see errors


    Scenario: Merge multiple submissions with zip
      Given 1 database exists
      Given I am on the new_submission page
      Given I fill in valid submission parameters
      Given I select a zip file
      And I check "merge_files"
      Given I submit the form
      Then I should see "successfully"

    Scenario: Merge multiple submissions with empty zip
      Given 1 database exists
      Given I am on the new_submission page
      Given I fill in valid submission parameters
      Given I select an empty zip file
      And I check "merge_files"
      Given I submit the form
      Then I should see errors

    Scenario: Merge multiple submissions with invalid zip
        Given 1 database exists
        Given I am on the new_submission page
        Given I fill in valid submission parameters
        Given I select an invalid zip file
        And I check "merge_files"
        Given I submit the form
        Then I should see errors
