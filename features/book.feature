Feature: Make HTTP requests on Books API 

Scenario: Fetch all books
    Given the service is running
    When I send HTTP Get request
    Then I receive a valid 200 response code
    And I get confirmation that there are books in the database
    Then response body matches the JSON schema for "books"

Scenario: Fetch one book
    Given the service is running
    When I send HTTP Get request for book 5
    Then response body matches the JSON schema for "book"

Scenario: POST a new book
    Given the service is running
    When I send HTTP POST request
    Then I receive a valid 200 response code

Scenario: Update an existing book
    Given the service is running
    When I send an HTTP PUT request for book 5
    Then I get a valid 200 response code
    And the updated book matches the json schema

Scenario: Delete an existing book
    Given the service is running
    When I send an HTTP DELETE request for book 7
    And I get an HTTP response code 404
        