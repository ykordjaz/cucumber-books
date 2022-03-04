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

# Then('I get confirmation that books match the book json schema') do
#   # @user_response = JSON.parse(@response.body)
#   # the response body is a JSON string that contains an array of books (aka objects) => confirmed by "p"  
#   # "[{\"id\":1,\"title\":\"Nine Coaches Waiting\...........
#   expect(@response).to match_response_schema("book")
# end

# Fetch one book - The second scenario

When('I send HTTP Get request for book {int}') do |book_id|
  uri = URI("http://127.0.0.1:3000/books/#{book_id}")
  @response = Net::HTTP.get_response(uri)
end

Then('response body matches the JSON schema for {string}') do |schema_name|
  # response.body is a string
  # if I pass response.body then the matcher will call .body again on the string (aka the body string)
  #  schema_name  == "book" (book.json)
  expect(@response).to match_response_schema(schema_name)
end

Then('I get info on that specific book') do
  pending # Write code here that turns the phrase above into concrete actions
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

  # p @response #  #<Net::HTTPOK 200 OK readbody=true> => it already includes the response body
  # p @response.body # "{\"id\":173,\"title\":\"random title\",\"author\":\"random author\"....}"
  end 
end


# # PUT
When('I send an HTTP PUT request for book {int}') do |id| 
  uri = URI("http://127.0.0.1:3000/books/#{id}") 
  http = Net::HTTP.new(uri.host, uri.port)
  @request = Net::HTTP::Put.new(uri)
  @request['Content-Type']='application/json'
  @updated_book = @request.set_form_data(
    title: "updated title",
    author: "updated author",
    genre: "updated genre",
    isbn: "updated 553877793955-X",
    language: "updated lang"
    )
  @request.body = @updated_book
  @updated_request = Net::HTTP::Get.new(uri)
  @response = http.request(@updated_request)
  end

Then('I get a valid {int} response code') do |int|
    expect(@response.code).to eq(int.to_s)
end

Then('the updated book matches the json schema') do
  expect(@response).to match_response_schema("book")
end

When('I send an HTTP DELETE request for book {int}') do |id|
  uri = URI("http://127.0.0.1:3000/books/#{id}") 
  http = Net::HTTP.new(uri.host, uri.port)
  @request = Net::HTTP::Delete.new(uri.path)
  @response = http.request(@request)
  puts "deleted #{@response}"
  @updated_request = Net::HTTP::Get.new(uri)
  @updated_response = http.request(@updated_request)
end

Then('I get an HTTP response code {int}') do |int|
expect(@updated_response.code).to eq("#{int}")
end
