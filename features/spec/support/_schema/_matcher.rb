require 'rspec/expectations'
# require 'json-schema'
# require 'json'


# define a custom RSpec matcher that validates the response object in our request spec against a specified JSON schema:

# the matcher already know how to extract the body from the response object (so no need to compare "@response.BODY" with the schema, but @response alone is enough - it already contains a body.)

RSpec::Matchers.define :match_response_schema do |schema|
    match do |response|
        schema_directory = "#{Dir.pwd}/features/spec/support/schemas"
        # schema_directory = '/home/yasmin/cucumber-books/features/spec/support/schemas'
        schema_path = "#{schema_directory}/#{schema}.json"
        # p Dir[schema_directory+'/*']
        # p File.exist?(schema_path)  # returns true
        # First parameter is either a file path or the actual schema itself
        # for some reason without line 16, the file couldn't be loaded/found
        schema = File.read(schema_path)
        # puts schema
        JSON::Validator.validate!(schema, response.body, strict: true)
    end
end
  