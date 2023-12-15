# Create a large file

```sh
cd /workspace/AWS-Examples/s3/multipart-upload/
dd if=/dev/zero of=largefile.txt bs=1M count=50
ls -lah | grep large
```


# Create a new bucket

```sh
aws s3 mb s3://multipart-fun-ab-3252
```

## Initiate

```sh
aws s3api create-multipart-upload --bucket multipart-fun-ab-3252 --key 'largefile.txt'
```

> remember to grab the upload id:
>eg. vnEygsN.OhFOgZxnWiWtbrOCyRH3pQolZtVXF7zcyYkTMvFrB1qCf2sQrpmeVDPjwOwdwkNSIbKN.fF34vU5kWp3erm9.oJHtulR7CnvkVaU5wQnQaip9KIENe_3bpAt

## List multipart uploads

aws s3api list-multipart-uploads --bucket multipart-fun-ab-3252 --query Uploads[].UploadId

# Split the file

split -b 10M -d largefile.txt part-

# Upload Part

export UPLOAD_ID="vnEygsN.OhFOgZxnWiWtbrOCyRH3pQolZtVXF7zcyYkTMvFrB1qCf2sQrpmeVDPjwOwdwkNSIbKN.fF34vU5kWp3erm9.oJHtulR7CnvkVaU5wQnQaip9KIENe_3bpAt"
env | grep UPLOAD

export BUCKET="multipart-fun-ab-3252"

> This argument is of type: streaming blob. Its value must be the path to a file (e.g. path/to/file) and must not be prefixed with file:// or fileb://

aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 1 --body part-00 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 2 --body part-01 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 3 --body part-02 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 4 --body part-03 --upload-id $UPLOAD_ID
aws s3api upload-part --bucket $BUCKET --key 'largefile.txt' --part-number 5 --body part-04 --upload-id $UPLOAD_ID

## Get all the parts with their etags

aws s3api list-parts --bucket $BUCKET --key 'largefile.txt' --upload-id $UPLOAD_ID --query "Parts[].{PartNumber: PartNumber, ETag: ETag}" > parts.json

## Complete

aws s3api complete-multipart-upload --multipart-upload file://parts.json --bucket $BUCKET --key 'largefile.txt' --upload-id $UPLOAD_ID

## Cleanup

aws s3 rm s3://multipart-fun-ab-3252/largefile.txt
aws s3 rb s3://multipart-fun-ab-3252