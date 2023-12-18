## Create a bucket with an S3 Glacier file

aws s3 mb s3://s3-glacier-fun-ab-1512

echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://s3-glacier-fun-ab-1512 --storage-class GLACIER

## Copy the file


aws s3 cp s3://s3-glacier-fun-ab-1512/hello.txt hello.txt

> This should fail because you have to restore the object

## Restore the Object

aws s3api restore-object \
    --bucket s3-glacier-fun-ab-1512 \
    --key hello.txt \
    --restore-request Days=1