# Oliver Twist Book

chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://e-school.kmutt.ac.th/elibrary/Upload/EBook/DSIL_Lib_E1312881157.pdf

## Create bucket

aws s3 mb s3://kendra-exp-223 --region us-east-1
cd split
aws s3 sync . s3://kendra-exp-223 --region us-east-1

## Creating our Index

```sh
aws kendra create-index \
--edition DEVELOPER_EDITION \
--name my-index \
--description "My Index" \
--region us-east-1 \
--role-arn arn:aws:iam::982383527471:role/KendraIndexRole
```

## Creating our Data Source

aws kendra create-data-source \
--index-id 62b0d9f1-b38b-44a6-8152-ff7427fdff08 \
--name my-data-source \
--role-arn arn:aws:iam::982383527471:role/KendraDataSourceRole \
--type S3 \
--configuration '{"S3Configuration":{"BucketName": "kendra-exp-223"}}' \
--region us-east-1



## Sync

```sh
aws kendra start-data-source-sync-job \
--id e3ceb99f-8574-4ff7-95c7-2e113c2ffc75 \
--index-id 62b0d9f1-b38b-44a6-8152-ff7427fdff08 \
--region us-east-1
```

# Query

```sh
aws kendra query \
--index-id 62b0d9f1-b38b-44a6-8152-ff7427fdff08 \
--query-text "You can talk as you eat, can't you?" \
--region us-east-1
```