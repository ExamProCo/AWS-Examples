#!/usr/bin/env bash
echo "== delete bucket"

# Check for bucket name
if [ -z "$1" ]; then
    echo "There needs to be a bucket name eg. ./bucket my-bucket-name"
    exit 1
fi

BUCKET_NAME=$1

# https://docs.aws.amazon.com/cli/latest/reference/s3api/create-bucket.html
aws s3api delete-bucket \
--bucket $BUCKET_NAME