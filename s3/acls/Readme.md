## Create a new bucket

```sh
aws s3api create-bucket --bucket acl-example-ab-5235 --region us-east-1
```

## Turn of Block Public Access for ACLs

```sh
aws s3api put-public-access-block \
--bucket acl-example-ab-5235 \
--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true"
```

```sh
aws s3api get-public-access-block --bucket acl-example-ab-5235
```

## Change Bucket Ownership


```sh
aws s3api put-bucket-ownership-controls \
--bucket acl-example-ab-5235 \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"
```

## Change ACLs to allow for a user in another AWS Account

```sh
aws s3api put-bucket-acl \
--bucket acl-example-ab-5235 \
--access-control-policy file:///workspace/AWS-Examples/s3/acls/policy.json
```

## Access Bucket from other account

```sh
touch bootcamp.txt
aws s3 cp bootcamp.txt s3://acl-example-ab-5235
aws s3 ls s3://acl-example-ab-5235
```

## Cleanup

```sh
aws s3 rm s3://acl-example-ab-5235/bootcamp.txt
aws s3 rb s3://acl-example-ab-5235
```