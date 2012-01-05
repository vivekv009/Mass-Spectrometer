Feature: CRUD Submissions
  As a user
  I can add and delete submissions.
  
	Background:
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
    	Given "user" is approved
    	Given "user" in enabled
    	When I sign in as "user/foobar"
		
	Scenario: Add submission to the queue with receiving emails by default
        Given 1 database exists
		Given I am on the new_submission page
		Given I fill in valid submission parameters
        Given I select a single file
        Given I submit the form
        Then I should see successfully 

    Scenario: Add submission to the queue without recieving emails
        Given 1 database exists
        Given I am on the new_submission page
        Given I fill in valid submission parameters
        Given I select a single file
        And I uncheck "submission_email"
        Given I submit the form
        Then I should see successfully 
		
	Scenario: Add multiple submissions to the queue	
		Given 1 p submissions exist
		Given I am on the new_submission page
		Given I fill in valid submission parameters
        Given I select a single file
        Given I submit the form
		Then Waiting should be on page

    Scenario: Add Empty Submission to the queue
        Given I am on the new_submission page
        Given I submit the form
        Then I should see errors

    Scenario: Cancel my submissions
		Given 1 w submissions exist
        Given I am on the submission_queue page
        When I cancel submission 1
        Then I should see "Successfully cancelled submission"
        Given I am on the submission_results page
        Then Cancelled should be on page

    Scenario: Try to Cancel other submissions
		Given 1 w submissions exist
		Given 1 w submissions exist by another user
        Given I am on the submission_queue page
        Then I should not see "destroy_2"


    Scenario: Destroy my submissions
        Given 1 c submissions exist
        Given I am on the submission_results page
        Then I should see "Submission c_1"
        When I destroy submission 1
        Then I should see "Successfully deleted submission"
        Then I should not see "Submission c_1"

    Scenario: Set Output file format
        Given 1 database exists
        Given I am on the new_submission page
        Given I select a single file
        Given I fill in valid submission parameters
        Given I select CSV as Output File
        Given I submit the form
        Then show me the page
        Then I should see ".csv"
