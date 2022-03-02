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

# Scenario: POST a new book
#     Given the service is running
#     When I send HTTP POST request
#     Then I receive a valid 200 response code
#     And I get info on that specific book

# Scenario: Update an existing book
#     Given the service is running
#     When I sent an HTTP PUT request
#     Then I get a valid 200 response code
#     And I get the updated info on the book