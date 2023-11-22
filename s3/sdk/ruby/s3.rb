require 'aws-sdk-s3'
require 'pry'
require 'securerandom'
client = Aws::S3::Client.new

bucket_name = ENV['BUCKET_NAME']

resp = client.create_bucket({
  bucket: bucket_name,
  create_bucket_configuration: {
    location_constraint: "ca-central-1", 
  }
})

number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

number_of_files.times.each do |i|
  puts "i: #{i}"
  filename = "file_#{i}.txt"
  output_path = "/tmp/#{filename}"

  File.open(output_path, "w") do |f| 
    f.write SecureRandom.uuid  
  end

  File.open(output_path, 'rb') do |file|
    resp = client.put_object({
      key: filename,
      body: file,
      bucket: bucket_name
    })
  end
end

#resp = client.delete_bucket({
#  bucket: bucket_name
#})