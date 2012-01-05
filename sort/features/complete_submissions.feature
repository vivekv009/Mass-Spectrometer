Feature: Complete Submissions
  As a user
  I can view queued, view results history, add and delete submissions.

	Background:
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      And "user" is approved
      And "user" in enabled
      When I sign in as "user/foobar"
      Given 1 database exists with 1 versions

    @background-jobs
	Scenario: Create new submission and download results
      Given I am on the new_submission page
      Given I fill in valid submission parameters
      Given I select a single file
      Given I submit the form
      Then I should see successfully
      #Given jobs are run
      Given I am on the submission_results page
      #Given show me the page
      #Results 1 to 3 are added to the queue - 4-9 are results
      When Submission 1 has a results file
      Given I follow "Show_1"
      And I follow "Export"
      Then I should receive a omx file



	
