# app.rb
require 'sinatra'
require 'json'
require 'net/http'
require 'pry'

# curl -X POST http://example.com/endpoint -H "Content-Type: application/json" -d '{"key1": "value1", "key2": "value2"}'

# Route that accepts POST requests to '/data'
post '/data' do
  request.body.rewind
  begin
    data = JSON.parse(request.body.read)
    case data['Type']
    when 'SubscriptionConfirmation' # we confirmed the subscription
      confirm_subscription(data['SubscribeURL'])
    when 'Notification' # we recieved the message
      json = JSON.pretty_generate(data)
      File.open("/workspace/AWS-Examples/s3/event-notifications/tmp/log.json", "w") { |f| f.write json }
    else
      raise "Unknown type"
    end

  rescue JSON::ParserError
    status 400
    "Invalid JSON format"
  end
end

def confirm_subscription(url)
  uri = URI.parse(url)
  Net::HTTP.get_response(uri)
end