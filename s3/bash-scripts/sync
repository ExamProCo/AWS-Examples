#!/usr/bin/env bash
echo "== sync"
# Exit immediately if any command returns a non-zero status
set -e

# Check for bucket name
if [ -z "$1" ]; then
    echo "There needs to be a bucket name eg. ./bucket my-bucket-name"
    exit 1
fi


# Check for filename prefix
if [ -z "$2" ]; then
    echo "There needs to be a filename prefix eg. ./bucket my-bucket-name my-filename-prefix"
    exit 1
fi

BUCKET_NAME=$1
FILENAME_PREFIX=$2

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

aws s3 sync $OUTPUT_DIR s3://$BUCKET_NAME/files