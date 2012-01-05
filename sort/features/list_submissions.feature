Feature: List Submissions
  As a user
  I can view queued, view results history, add and delete submissions.

	Background:
    Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
    And "user" is approved
    And "user" in enabled
    When I sign in as "user/foobar"
		
		Given 1 p submissions exist
		Given 2 w submissions exist
		Given 4 c submissions exist
        Given 1 f submissions exist
		
	Scenario: List queue
		Given I am on the submission_queue page
		Then I should see the queued submissions
		
	Scenario: List results
		Given I am on the submission_results page
		Then I should see the submission results

    Scenario: Download results
		Given I am on the submission_results page
        #Results 1 to 3 are added to the queue - 4-9 are results
        When Submission 4 has a results file
        Given I follow "Show_4"
        And I follow "Export"
        Then I should receive a omx file

    Scenario: Can't Download Results
		Given I am on the submission_results page
        Given I follow "Show_5"
        And I follow "Export"
        Then I should see "Could not download results file"

		
	
