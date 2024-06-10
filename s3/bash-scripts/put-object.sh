#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

# Heading
echo "Creating 5 Random Files and Displaying Directory Tree"

# Define the output directory
output_dir="/tmp/s3-temp-bash-scripts"

# Remove the directory if it already exists
if [ -d "$output_dir" ]; then
    echo "Removing existing directory: $output_dir"
    rm -rf "$output_dir"
fi

# Create the directory
mkdir -p "$output_dir"

# Generate 5 random files
for i in {1..5}; do
    # Generate a random filename
    filename="$output_dir/file$i.txt"
    # Generate random content
    content=$(openssl rand -base64 32)
    # Write content to file
    echo "$content" > "$filename"
    echo "Created file: $filename"
done

# Display directory tree
echo "Directory Tree:"
tree "$output_dir"
