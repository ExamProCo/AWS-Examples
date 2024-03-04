require 'aws-sdk-firehose' # Make sure to include aws-sdk-kinesis
require 'pry'
#require 'base64'

# Initialize a Kinesis client
client = Aws::Firehose::Client.new

stream_name = 'dataf-1212-Firehose-gadcI69dfDSw'

# Prepare records
10.times.map do |i|
  data = {hello: "world: #{i}"}.to_json
  response = client.put_record(
    delivery_stream_name: stream_name,
    record: {data: data}
  )
  #binding.pry
  puts "Response: #{response.inspect}"
end