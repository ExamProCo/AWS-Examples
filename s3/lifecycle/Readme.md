## Create a new bucket

aws s3 mb s3://lifecycle-fun-ab-5424453

# Create lifecycle policy configuration

aws s3api put-bucket-lifecycle-configuration --bucket lifecycle-fun-ab-5424453 --lifecycle-configuration file://lifecycle.json

## Cleanup

aws s3 rb s3://lifecycle-fun-ab-5424453