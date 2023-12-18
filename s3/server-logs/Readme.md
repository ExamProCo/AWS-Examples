## Create two buckets

aws s3 mb s3://server-logs-source-ab-4242
aws s3 mb s3://server-logs-dest-ab-4242

# Create Logs folder for the destination bucket

aws s3api put-object --bucket server-logs-dest-ab-4242 --key Logs/

## Configure Server Logging

### Turn on logging for the source bucket
aws s3api put-bucket-logging --bucket server-logs-source-ab-4242 --bucket-logging-status file://logging.json

### Allow source buckets to put data into this bucket
aws s3api put-bucket-policy --bucket server-logs-dest-ab-4242 --policy file://policy.json 

## Source Data

echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://server-logs-source-ab-4242/hello.txt

echo "Hello Mars" > hello_mars.txt
aws s3 cp hello_mars.txt s3://server-logs-source-ab-4242/hello_mars.txt

echo "Hello Moon" > hello_moon.txt
aws s3 cp hello_moon.txt s3://server-logs-source-ab-4242/hello_moon.txt