require 'sinatra'
require 'aws-sdk-appconfigdata'
require 'json'

# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/AppConfig/Client.html

class MyApp < Sinatra::Base
  get '/hello' do
    client = Aws::AppConfigData::Client.new(
      region: 'us-east-1'
    )
    resp = client.start_configuration_session({
      application_identifier: "zcxkhf6", # required
      environment_identifier: "jtsusj3", # required
      configuration_profile_identifier: "nviwmge", # required
      required_minimum_poll_interval_in_seconds: 15
    })
    resp = client.get_latest_configuration({
      configuration_token: resp.initial_configuration_token # required
    })
    json_str = resp.configuration.read
    data = JSON.parse(json_str)
    if data['hello']['enabled']
      return 'Hello World!'
    else
      return 'Go away'
    end
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end