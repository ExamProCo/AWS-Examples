## Create an s3 bucket

aws s3 mb s3://replication-fun-ab-4535
aws s3 mb s3://replication-fun-us-east-ab-4535 --region us-east-1


## Turn on S3 Versioning for both buckets

aws s3api put-bucket-versioning --bucket replication-fun-ab-4535 --versioning-configuration Status=Enabled
aws s3api put-bucket-versioning --bucket replication-fun-us-east-ab-4535  --versioning-configuration Status=Enabled

# Create a Role and Policy for S3 Replication

aws iam create-policy --policy-name s3-replication-example --policy-document file://policy.json

aws iam create-role \
    --role-name s3-replication-role \
    --assume-role-policy-document file://trust.json

aws iam attach-role-policy \
    --policy-arn arn:aws:iam::982383527471:policy/s3-replication-example \
    --role-name s3-replication-role 

## Turn on Replication

aws s3api put-bucket-replication \
    --bucket replication-fun-ab-4535  \
    --replication-configuration file://replication.json


# create a file and upload to our bucket

echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://replication-fun-ab-4535/hello.txt

# check dest bucket to see if replication worked

aws s3 ls s3://replication-fun-us-east-ab-4535

# Cleanup

> empty and delete the buckets in the console its the easiest way to clear all versions