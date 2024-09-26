# Required libraries
require 'aws-sdk-s3'  # AWS SDK for S3 operations
require 'pry'         # Interactive shell for debugging
require 'securerandom' # For generating secure random strings (UUIDs)

# Prompt user for S3 bucket name
puts "Enter the bucket name:"
bucket_name = gets.chomp  # Get user input and remove trailing newline

# Prompt user for AWS region
puts "Enter the AWS region (e.g., us-west-2):"
region = gets.chomp  # Get user input and remove trailing newline

# Check if the bucket name and region are provided
if bucket_name.nil? || bucket_name.empty? || region.nil? || region.empty?
  puts "Bucket name and region are required."
  exit 1
end

# Initialize AWS S3 client
client = Aws::S3::Client.new(region: region) # Creating a new instance of the S3 client with the specified region

begin
  # Create S3 bucket
  resp = client.create_bucket({
    bucket: bucket_name,            # Name of the bucket
    create_bucket_configuration: {
      location_constraint: region   # Region for the bucket
    }
  })
  puts "Bucket '#{bucket_name}' created successfully in region '#{region}'."
rescue Aws::S3::Errors::BucketAlreadyExists
  puts "Bucket '#{bucket_name}' already exists."
rescue Aws::S3::Errors::ServiceError => e
  puts "Failed to create bucket: #{e.message}"
  exit 1
end

# Determine the number of files to create and upload
number_of_files = 1 + rand(6)     # Generating a random number between 1 and 6
puts "Number of files to create and upload: #{number_of_files}"

# Loop to create and upload each file
number_of_files.times do |i|
  puts "Creating and uploading file #{i+1} of #{number_of_files}..."
  filename = "file_#{i}.txt"      # Generating a filename for each file
  output_path = "/tmp/#{filename}"# Specifying the output path for the file

  # Writing a unique UUID to each file
  File.open(output_path, "w") do |f|
    f.write(SecureRandom.uuid)    # Write a random UUID to the file
  end

  begin
    # Open and read the file in binary mode, then upload it to S3
    File.open(output_path, 'rb') do |f|  # 'rb' mode for reading binary data
      client.put_object(                # Uploading the file to S3
        bucket: bucket_name,            # Bucket to upload to
        key: filename,                  # Key (filename) for the object in the bucket
        body: f                         # File content
      )
    end
    puts "File '#{filename}' uploaded successfully."
  rescue Aws::S3::Errors::ServiceError => e
    puts "Failed to upload file '#{filename}': #{e.message}"
  end
end

# Uncomment the following line if you want to start an interactive session
# binding.pry
