#!/bin/bash

# Prompt user to enter the bucket name
read -p "Enter the bucket name: " BUCKET_NAME

# Check if bucket name is empty
if [ -z "$BUCKET_NAME" ]; then
    echo "Bucket name must be provided."
    exit 1
fi

# List objects in the specified bucket
aws s3api list-objects --bucket "$BUCKET_NAME"
