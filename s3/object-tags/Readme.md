## Create a bucket

aws s3 mb s3://object-tags-fun-ab-524353

## Upload file

echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://object-tags-fun-ab-524353/hello.txt

## Apply Object Tagging

aws s3api put-object-tagging \
    --bucket object-tags-fun-ab-524353 \
    --key hello.txt \
    --tagging '{"TagSet": [{ "Key": "hello", "Value": "world" }]}'


##  Cleanup

aws s3 rm s3://object-tags-fun-ab-524353/hello.txt
aws s3 rb s3://object-tags-fun-ab-524353