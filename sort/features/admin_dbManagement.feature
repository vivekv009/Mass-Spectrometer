Feature: Admin managing databases 
  So that I can manage all the databases in the system
  As an admin
  I can perform actions on all databases in the system

	Background:
    Given I am an admin named "foo" with a username "admin", an email "admin@test.com" and password "foobar"
    And "admin" is approved
    And "admin" in enabled
    When I sign in as "admin/foobar"
    Given 2 enabled database exist along 2 enabled version


  # To list all exisitng databases in the system by an admin
  Scenario: Listing all databases
		Given I am on the databases page
    Then I should see all databases
   
  # admin disables someones database version 
  Scenario: disable one database version
    Given I am on the databases page
    And I show database number 1 versions
    And I follow "disable"
 
  # admin enables someones database version 
  Scenario: Enable one database version
    Given I am on the databases page
    And I show database number 1 versions
    And I follow "disable"
    And I follow "enable"

  # admin enables someones database version 
  Scenario: Destroy one database version
    Given I am on the databases page
    And I show database number 1 versions
    And I follow "disable"
    And I follow "destroy"

  # admin disables someones database (automatic)
  Scenario: Automatic database disabling 
    Given I am on the databases page
    And I show database number 1 versions
    And I follow "disable"
    And I follow "disable"

  # admin enables someones database  (automatic)
  Scenario: Automatic database enabling
    Given I am on the databases page
    And I show database number 1 versions
    And I follow "disable"
    And I follow "disable"
    And I show it under disabled databases
    And I show database number 1 versions
    And I follow "enable"
    And I follow "enable"

  # admin destroys someones database  (automatic)
  Scenario: Automatic database destruction
    Given I am on the databases page
    And I show database number 1 versions
    And I follow "disable"
    And I follow "destroy"
    And I follow "disable"
    And I show database number 1 versions
    And I follow "destroy"
    Then I should see "Database is completely removed from the system"

  # admin disables someones database (manual)
  Scenario: Disable a database
    Given I am on the databases page
    And I follow "disable"
  
  # admin enables someones database (manual)
  Scenario: Enable a database
    Given I am on the databases page
    And I follow "disable"
    And I follow "enable"
  
  # admin destroy someones database (manual)
  Scenario: Destroy a database
    Given I am on the databases page
    And I follow "disable"
    And I follow "destroy"  











