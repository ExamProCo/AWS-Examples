require 'json'
require 'aws-sdk-s3'

def lambda_handler(event:, context:)
  s3 = Aws::S3::Client.new(region: 'ca-central-1')
  bucket_name = 'gateway-endpoints-example'

  begin
    resp = s3.list_objects_v2(bucket: bucket_name)
    if resp.contents.empty?
      puts "No objects found in #{bucket_name}."
    else
      puts "Objects in #{bucket_name}:"
      resp.contents.each do |object|
        puts object.key
      end
    end
  rescue Aws::S3::Errors::ServiceError => e
    # In case of S3 errors, print the error message
    puts "Error listing objects: #{e}"
  end

  # Lambda functions need a return value, even if it's not used
  { statusCode: 200, body: JSON.generate('Listed objects successfully.') }
end