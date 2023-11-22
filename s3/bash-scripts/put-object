#!/usr/bin/env bash
echo "== put-object"

# Check for bucket name
if [ -z "$1" ]; then
    echo "There needs to be a bucket name eg. ./bucket my-bucket-name"
    exit 1
fi

if [ -z "$2" ]; then
    echo "There needs to be a filename eg. ./bucket my-bucket-name filename"
    exit 1
fi
BUCKET_NAME=$1
FILENAME=$2

OBJECT_KEY=$(basename "$FILENAME")

aws s3api put-object \
--bucket $BUCKET_NAME \
--body $FILENAME \
--key $OBJECT_KEY