#!/bin/bash

# Prompt user to enter bucket name
read -p "Enter the bucket name: " BUCKET_NAME

# Prompt user to enter region
read -p "Enter the region: " REGION

# Check if either bucket name or region is empty
if [ -z "$BUCKET_NAME" ] || [ -z "$REGION" ]; then
    echo "Both bucket name and region must be provided."
    exit 1
fi

# Create the bucket with the specified name and region
aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION"

# Check if bucket creation was successful
if [ $? -eq 0 ]; then
    echo "Bucket '$BUCKET_NAME' created successfully in region '$REGION'."
else
    echo "Failed to create bucket '$BUCKET_NAME' in region '$REGION'."
fi
