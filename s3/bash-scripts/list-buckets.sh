#!/bin/bash

echo "== Listing S3 Buckets =="

# List all S3 buckets along with their creation dates
buckets_with_dates=$(aws s3 ls | awk '{print $3, $1, $2}')

# Check if there are any buckets
if [ -z "$buckets_with_dates" ]; then
    echo "No buckets found."
    exit 0
fi

# Sort buckets by creation date (oldest first)
sorted_buckets=$(echo "$buckets_with_dates" | sort -k 2)

# Reverse the sorted list to have the newest bucket listed first
newest_first=$(echo "$sorted_buckets" | tac)

# Extract bucket names from the sorted list
bucket_names=$(echo "$newest_first" | awk '{print $1}')

# Print each bucket name
echo "Found bucket or buckets (newest first):"
echo "$bucket_names"
