Feature: User managing databases 
  So that I can manage my own databases in the system
  As the owner of the database 
  I can perform actions on my own databases in the system
  
  Background:
    Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
    Given "user" is approved
    Given "user" in enabled
    When I sign in as "user/foobar"

  # As a user I can add a database 
  Scenario: Add database
    #WARNING TESTS ARE BROKEN DUE TO DB UPLOADER
	Given I am on the databases page
	And I create a database
    #Then the database is added to the list
    #Then I should see database was successfully added

  #	Error: As a user I can't add a duplicate database
  Scenario: Add a duplicate databases
	Given I am on the databases page
	And I create a database
	Given I am on the databases page
	And I create a duplicate database  
	
  # As a user I can view my own databases versions
  Scenario: Show one my databases' versions
    Given 1 database exists with 1 version by "user"
	Given I am on the databases page
	And I show database number 1 versions
    Then I should see "1" "active" database version

  # As a user I can add database and update it with a new version
  Scenario: Add a new version of the database		
    #WARINING TEST IS BROKEN DUE TO DBUPLOADER
    Given 1 database exists with 1 version by "user"
	Given I am on the databases page
    #And I update a database with a another version	
    #Then I should see database was successfully added

  # As a user I can add a new version to a database with a different name
  #Scenario: Add a new version of the database with a different name	
        #Given I am on the databases page	
    #And I create a database		
    #Given I am on the databases page
    #And I upload a database version with a different name
    #Then I should see database was successfully added

  # Error: When updaing without uploading a file 	
  Scenario: Add no database version
    Given 1 database exists with 1 version by "user"
	Given I am on the databases page 
    #And I create a database 
    #Given I am on the databases page 
	And I do not upload a database version
	Then I should see database was not successfully added

  # Editing the database name
  Scenario: Edit the name of the database	
	Given I am on the databases page	
    Given 1 database exists with 1 version by "user"
	And I edit the database name
	Then I should see database name was successfully updated

  # As a user I can disable a version 
  Scenario: Disable a database version
    Given 1 database exists with 1 version by "user"
	Given I am on the databases page
	And I show database number 1 versions
	And I follow "disable"

  # As a user I can see the status of the job
  Scenario: The status of a database version is shown on the show version page
    Given 1 database exists with 4 differnt version states
    Given I am on the databases page
    And I show database number 1 versions
    Then I should see the 1 "Processing" status
    Then I should see the 1 "Error" status
    Then I should see the 2 "Success" status
    Given I show database version 1
    Then I should see database version 1
   
    
