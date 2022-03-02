require 'net/http'
require 'uri'
# require 'json_matchers/rspec'
require 'json-schema'
require 'json'

  Given('the service is running') do
    uri = URI('http://127.0.0.1:3000/healthcheck')
    response = Net::HTTP.get_response(uri) 
    expect(response.code).to eq "200"
  end

  # GET
  When('I send HTTP Get request') do
    uri = URI('http://127.0.0.1:3000/books')
    @response = Net::HTTP.get_response(uri)
  end
  
  Then('I receive a valid {int} response code') do |int|
    expect(@response.code).to eq(int.to_s)
  end
  
  Then('I get confirmation that there are books in the database') do
    expect(@response.body.size).to be > 0
  end
  
  Then('I get confirmation that books match the book json schema') do
    expect(@response).to match_response_schema("book")
  end
  

  # POST
  When('I send HTTP POST request') do
    uri = URI('http://127.0.0.1:3000/books')    
    http = Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new(uri)
      request['Content-Type']='application/json'
      @new_book = {
        title: "random title",
        author: "random author",
        genre: "random genre",
        isbn: "553877793955-X",
        language: "randomese"
      }
      # without ".to_json" : error => undefined method `bytesize' for {"title"=>"random title", "author"=>"random author", "genre"=>"random genre", "isbn"=>"553877793955-X", "language"=>"randomese"}:Hash (NoMethodError)
    request.body = @new_book.to_json
    @response = http.request(request)

    # p @response #  #<Net::HTTPOK 200 OK readbody=true>
    # p @response.body # "{\"id\":173,\"title\":\"random title\",\"author\":\"random author\",\"genre\":\"random genre\",\"isbn\":\"553877793955-X\",\"language\":\"randomese\",\"created_at\":\"2022-03-02T13:25:30.024Z\",\"updated_at\":\"2022-03-02T13:25:30.024Z\"}"
    # p @response.code # "200"
    # p @response.message # "OK"
  end
end

Then('I get info on that specific user') do
  uri = URI('http://127.0.0.1:3000/books') 
    expect(@response).to match_response_schema("book")
    # I don't get why @response.body didn't match response schema, but @response did!!
  end
  