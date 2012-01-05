 Feature: Show vesions
  So that the the list of all the versions for a current database are shown
  As a user
  I can view all the versions
  
	Background:
      Given I am a user named "foo" with a username "user", an email "user@test.com" and password "foobar"
      Given "user" is approved
   	  Given "user" in enabled
      When I sign in as "user/foobar"
	  Given 1 database exists with 4 versions
	  
	Scenario: Add database
	  Given I request database 1s versions
		