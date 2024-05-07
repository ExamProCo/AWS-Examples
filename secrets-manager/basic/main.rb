# Use this code snippet in your app.
# If you need more information about configurations or implementing the sample code, visit the AWS docs:
# https://aws.amazon.com/developer/language/ruby/

require 'aws-sdk-secretsmanager'
require 'pry'

def get_secret
  client = Aws::SecretsManager::Client.new(region: 'ca-central-1')

  begin
    get_secret_value_response = client.get_secret_value(secret_id: 'MySecret-RuV3HAAeO2Dy')
  rescue StandardError => e
    # For a list of exceptions thrown, see
    # https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_GetSecretValue.html
    raise e
  end

  secret = get_secret_value_response.secret_string
  data = JSON.parse secret
  puts data['username']
  puts data['password']
  # Your code goes here.
end

get_secret