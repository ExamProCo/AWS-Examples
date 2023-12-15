require 'aws-sdk-s3'
require 'pry'
require 'json'
require 'pp'

# https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html

client = Aws::S3::Client.new

query = <<-SQL
SELECT 
  CAST(t.Rank as INT) as rank,
  t."Release Year" as release_year,
  CAST(t."IMDb Rating" as float) as rating,
  t.Title as title,
  t.Genre as genre
FROM s3object t
WHERE CAST(t.Rank as INT) < 1
LIMIT 4
SQL
#binding.pry

attrs = {
  bucket: "s3-select-fun-ab-35252", # required
  key: "top_20_animes.csv", # required
  expression: query, # required
  expression_type: "SQL", # required, accepts SQL
  input_serialization: { # required
    csv: {
      file_header_info: "USE", # use the first list as the header.
    },
    compression_type: "NONE" # accepts NONE, GZIP, BZIP2
  },
  output_serialization: { # required
    # csv: { quote_fields: "ALWAYS" # accepts ALWAYS, ASNEEDED }
    json: {}
  }
}

string_results = nil
resp = client.select_object_content(attrs) do |stream|
  stream.on_error_event do |event|
    # catch unmodeled error event in the stream
    raise event
    # => Aws::Errors::EventError
    # event.event_type => :error
    # event.error_code => String
    # event.error_message => String
  end # stream.on_error_event

  stream.on_event do |event|
    # process all events arrive
    case event.event_type
    when :records
      string_results = event.payload.string
    when :stats
      puts "bytes scanned: #{event.details.bytes_scanned}" #=> Integer
      puts "bytes processed:#{event.details.bytes_processed}" #=> Integer
      puts "bytes returned: #{event.details.bytes_returned}" #=> Integer
    end
  end # stream.on_event
end  # client.select_object_content
json = "[#{string_results.split("\n").join(',')}]"
data = JSON.parse json

puts JSON.pretty_generate(data)