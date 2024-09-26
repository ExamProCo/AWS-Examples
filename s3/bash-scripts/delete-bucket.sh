#!/bin/bash

echo "List of existing buckets:"
# List existing buckets
buckets=$(aws s3api list-buckets --query 'Buckets[].Name' --output text)

# Check if there are any buckets
if [ -z "$buckets" ]; then
    echo "No buckets found."
    exit 0
fi

# Print each bucket name with index
echo "Available buckets:"
select bucket in $buckets; do
    break
done

# Prompt user for confirmation before deleting the bucket
read -p "Are you sure you want to delete bucket '$bucket'? (yes/no): " confirmation

# Check user confirmation
if [ "$confirmation" != "yes" ]; then
    echo "Bucket deletion canceled."
    exit 0
fi

# Delete the specified bucket
aws s3api delete-bucket --bucket "$bucket"

# Check if bucket deletion was successful
if [ $? -eq 0 ]; then
    echo "Bucket '$bucket' deleted successfully."
else
    echo "Failed to delete bucket '$bucket'."
fi
