#!/bin/bash

echo "== Sync"

# Check if bucket name is provided as argument
if [ -z "$1" ]; then
    # Prompt user to enter the bucket name
    read -p "Enter the bucket name: " BUCKET_NAME

    # Check if bucket name is provided
    if [ -z "$BUCKET_NAME" ]; then
        echo "There needs to be a bucket name."
        exit 1
    fi

    # Prompt user to enter the filename prefix
    read -p "Enter the filename prefix: " FILENAME_PREFIX

    # Check if filename prefix is provided
    if [ -z "$FILENAME_PREFIX" ]; then
        echo "There needs to be a filename prefix."
        exit 1
    fi
else
    BUCKET_NAME=$1
    FILENAME_PREFIX=$2
fi

# where we'll store these files
OUTPUT_DIR="/tmp/s3-bash-scripts"

# remove folder if it already exists
rm -r $OUTPUT_DIR

# lets create output folder
mkdir -p $OUTPUT_DIR

# generate a random number
# to determine how many files to create
NUM_FILES=$((RANDOM % 6 + 5))

for ((i=1; i<=$NUM_FILES; i++)); do
    # Generate a random filename
    FILENAME="$OUTPUT_DIR/${FILENAME_PREFIX}_$i.txt"

    # Generate random data and write it to the file
    dd if=/dev/urandom of="$FILENAME" bs=1024 count=$((RANDOM % 1024 + 1)) 2>/dev/null
done

tree $OUTPUT_DIR

# Sync the files to the specified S3 bucket
aws s3 sync $OUTPUT_DIR s3://$BUCKET_NAME/files

# Check if synchronization was successful
if [ $? -eq 0 ]; then
    echo "Synchronization to bucket '$BUCKET_NAME' successful."
else
    echo "Failed to synchronize files to bucket '$BUCKET_NAME'."
fi
