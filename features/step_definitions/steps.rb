require 'net/http'
require 'uri'
# require 'json_matchers/rspec'

  Given('the service is running') do
    uri = URI('http://127.0.0.1:3000/healthcheck')
    res = Net::HTTP.get_response(uri) 
    # p res.code
    expect(res.code).to eq "200"
  end

  When('I send HTTP Get request') do
    uri = URI('http://127.0.0.1:3000/books')
    @res = Net::HTTP.get_response(uri)
  end
  
  Then('I receive a valid {int} response code') do |int|
    expect(@res.code).to eq(int.to_s)
    # expect(@res.code).to eq "200" also works
  end
  
  Then('I get confirmation that there are books in the database') do
    expect(@res.body.size).to be > 0
  end
  
  Then('I get confirmation that books match the book json schema') do
    expect(@res).to match_response_schema("book".to_s)
  end
  