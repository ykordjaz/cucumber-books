Feature: Make HTTP requests on Books API 

Scenario: Fetch all books
    Given the service is running
    When I send HTTP Get request
    Then I receive a valid 200 response code
    And I get confirmation that there are books in the database