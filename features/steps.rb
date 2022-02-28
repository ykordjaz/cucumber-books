require 'net/http'
require 'uri'
# require 'json_matchers/rspec'

Given('the service is running') do
    uri = URI('http://127.0.0.1:3000/books')
    Net::HTTP.get(uri) # => String
end
  
  When('I send HTTP Get request') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  Then('I receive a valid {int} response code') do |int|
  # Then('I receive a valid {float} response code') do |float|
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  Then('I get confirmation that there are books in the database') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  