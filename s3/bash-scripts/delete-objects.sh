#!/bin/bash

echo "== Delete S3 Objects =="

# List all S3 buckets
buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text)

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

# List objects in the selected bucket
objects=$(aws s3 ls "s3://$bucket" --recursive --human-readable --summarize)

# Check if there are any objects
if [ -z "$objects" ]; then
    echo "No objects found in bucket '$bucket'."
    exit 0
fi

# Print objects in the selected bucket with index
echo "Objects in bucket '$bucket':"
echo "$objects" | awk '{print NR, $0}'

# Prompt user to choose to delete all objects or specific ones
read -p "Do you want to delete all objects? (yes/no): " DELETE_ALL

# Check user's choice
if [ "$DELETE_ALL" = "yes" ]; then
    # Confirm with user before deleting all objects
    read -p "Are you sure you want to delete all objects from bucket '$bucket'? (yes/no): " CONFIRM
    if [ "$CONFIRM" != "yes" ]; then
        echo "Deletion canceled."
        exit 0
    fi

    # Delete all objects from the bucket
    aws s3 rm "s3://$bucket" --recursive

    # Check if all objects deletion was successful
    if [ $? -eq 0 ]; then
        echo "All objects deleted successfully from bucket '$bucket'."
    else
        echo "Failed to delete all objects from bucket '$bucket'."
    fi
else
    # Prompt user to enter the index of the object to delete
    read -p "Enter the index of the object to delete (or 0 to cancel): " object_index

    # Validate user input
    if [ "$object_index" -eq 0 ]; then
        echo "Deletion canceled."
        exit 0
    fi

    # Extract the object key from the selected index
    object_key=$(echo "$objects" | sed -n "${object_index}p" | awk '{print $NF}')

    # Confirm with user before deleting the object
    read -p "Are you sure you want to delete object '$object_key' from bucket '$bucket'? (yes/no): " CONFIRM
    if [ "$CONFIRM" != "yes" ]; then
        echo "Deletion canceled."
        exit 0
    fi

    # Delete the selected object from the bucket
    aws s3 rm "s3://$bucket/$object_key"

    # Check if object deletion was successful
    if [ $? -eq 0 ]; then
        echo "Object '$object_key' deleted successfully from bucket '$bucket'."
    else
        echo "Failed to delete object '$object_key' from bucket '$bucket'."
    fi
fi
