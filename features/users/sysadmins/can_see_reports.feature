Feature: Admin can view reports
  In order to view all system data
  As an Admin
  I want to be able to see an overview report

  Background:
    Given an organization exists with name: "organization1"
      And a data_request exists with title: "data_request1", organization: the organization
      And an sysadmin exists with email: "sysadmin@hrtapp.com", organization: the organization
     When I am signed in as "sysadmin@hrtapp.com"

  # do as part of the new sysadmin reports stories
  # @wip
  # Scenario: See reports overview
  #   When I follow "Reports"
  #   Then I should see "Overview" within "h1"
  #   And I should see "data_request1" within "h1"

  Scenario: See reports->dynamic
    When I follow "Reports"
    And I follow "Dynamic"
    Then I should see "Dynamic Reports" within "h1"
    And I should see "data_request1" within "h1"

  Scenario: See reports -> files
    When I follow "Reports"
    And I follow "Files"
    Then I should see "Files" within "h1"

