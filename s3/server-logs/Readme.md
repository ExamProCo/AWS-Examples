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

## Download Access Logs

aws s3 sync s3://server-logs-dest-ab-4242/Logs/ Logs/

## Query via Athena

aws s3 mb s3://athena-results-ab-64363

https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-s3-access-logs-to-identify-requests.html


```sql
CREATE DATABASE s3_access_logs_db
```

```sql
CREATE EXTERNAL TABLE `s3_access_logs_db.mybucket_logs`(
  `bucketowner` STRING, 
  `bucket_name` STRING, 
  `requestdatetime` STRING, 
  `remoteip` STRING, 
  `requester` STRING, 
  `requestid` STRING, 
  `operation` STRING, 
  `key` STRING, 
  `request_uri` STRING, 
  `httpstatus` STRING, 
  `errorcode` STRING, 
  `bytessent` BIGINT, 
  `objectsize` BIGINT, 
  `totaltime` STRING, 
  `turnaroundtime` STRING, 
  `referrer` STRING, 
  `useragent` STRING, 
  `versionid` STRING, 
  `hostid` STRING, 
  `sigv` STRING, 
  `ciphersuite` STRING, 
  `authtype` STRING, 
  `endpoint` STRING, 
  `tlsversion` STRING,
  `accesspointarn` STRING,
  `aclrequired` STRING)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.RegexSerDe' 
WITH SERDEPROPERTIES ( 
  'input.regex'='([^ ]*) ([^ ]*) \\[(.*?)\\] ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) (-|[0-9]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) (\"[^\"]*\"|-) ([^ ]*)(?: ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*))?.*$') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://server-logs-dest-ab-4242/Logs/'
```

arn:aws:iam::982383527471:user/andrewbrown


```sql
SELECT bucket_name, key, operation
FROM s3_access_logs_db.mybucket_logs 
WHERE requester='arn:aws:iam::982383527471:user/andrewbrown';
```

## Cleanup

empty your buckets in the console than delete them

aws s3 rb s3://server-logs-source-ab-4242
aws s3 rb s3://server-logs-dest-ab-4242