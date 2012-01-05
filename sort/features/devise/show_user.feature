Feature: Show Users
  As a admin to the website
  I want to see registered users listed on the homepage
  so I can know if the site has users

    Scenario: Viewing users
      Given I am a user named "Active User" with a username "user", an email "user@test.com" and password "foobar"
      Given I am an admin named "Admin User" with a username "admin", an email "admin@test.com" and password "foobar"
      
      When I sign in as "admin/foobar"
      
      When I go to the users_manage page
      Then I should see "Active User"

