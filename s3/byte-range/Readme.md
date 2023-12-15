## Create a bucket

aws s3 mb s3://range-run-ab-53252

## Upload our file

aws s3api put-object --bucket range-run-ab-53252 --key hello.txt --body hello.txt

## Get an Object range of bytes

### Get only the word hello
aws s3api get-object --bucket range-run-ab-53252 --key hello.txt --range bytes=0-4 range.txt

### Get only the word world

aws s3api get-object --bucket range-run-ab-53252 --key hello.txt --range bytes=6-10 range.txt

## Cleanup

aws s3 rm s3://range-run-ab-53252/hello.txt
aws s3 rb s3://range-run-ab-53252