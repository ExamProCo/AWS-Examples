## Create Buckets

```sh
aws s3 mb s3://source-datasync-32523
aws s3 mb s3://dest-datasync-32523
```

# Upload File

```sh
touch hello.txt
aws s3 cp hello.txt s3://source-datasync-32523/data/hello.txt
```