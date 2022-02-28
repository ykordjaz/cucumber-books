require 'rspec/expectations'

RSpec::Matchers.define :match_response_schema do |schema|
    match do |response|
        schema_directory = "#{Dir.pwd}/features/spec/support/schemas"
        # schema_directory = '/home/yasmin/cucumber-books/features/spec/support/schemas'
        schema_path = "#{schema_directory}/#{schema}.json"
        # p Dir[schema_directory+'/*']
        # p File.exist?(schema_path)  # returns true
        # First parameter is either a file path or the actual schema itself
        # for some reason without line 16, the file couldn't be loaded/found
        # schema = File.read(schema_path)
        JSON::Validator.validate!(schema_path, response.body, strict: true)
    end
end
  