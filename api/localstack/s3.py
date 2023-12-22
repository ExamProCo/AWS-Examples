import boto3

# Configure AWS credentials
# Assuming they are set in environment variables or AWS credentials file

# Create an S3 client with a custom endpoint
s3_client = boto3.client(
    's3',
    region_name='us-east-1',
    endpoint_url='http://0.0.0.0:4566'
)
s3_client.create_bucket(Bucket='google.com')