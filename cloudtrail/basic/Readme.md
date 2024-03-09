# Create a bucket for cloudtrail logs

aws s3 mb s3://my-cloudtrail-ab-1212

# Create bucket policy to allow cloud trail to put to bucket

aws s3api put-bucket-policy --bucket my-cloudtrail-ab-1212 --policy file://bucket-policy.json

# Create Trail
aws cloudtrail create-trail \
--name MyTrail \
--s3-bucket-name my-cloudtrail-ab-1212 \
--region ca-central-1

# Start Logging

aws cloudtrail start-logging --name MyTrail
