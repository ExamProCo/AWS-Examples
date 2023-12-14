## Create a new s3 bucket

```md
aws s3 mb s3://checksums-examples-ab-2342
```

## Create a file that will we do a checksum on

```
echo "Hello Mars" > myfile.txt
```

## Get a checksum of a file for md5

```md
md5sum myfile.txt 
# 8ed2d86f12620cdba4c976ff6651637f  myfile.txt
```

## Upload our file and look at its etag

```
aws s3 cp myfile.txt s3://checksums-examples-ab-2342
aws s3api head-object --bucket checksums-examples-ab-2342 --key myfile.txt
```

## Lets upload a file with a different kind of checsum

Using a script
```sh
bundle exec ruby crc.rb
```

using a library
```sh
sha1sum myfile.txt 
```

```sh
aws s3api put-object \
--bucket="checksums-examples-ab-2342" \
--key="myfilesha1.txt" \
--body="myfile.txt" \
--checksum-algorithm="SHA1" \
--checksum-sha1="YzI4Y2NjMmM1ZTIxNDAzNjgwNjAxNGRmOWZiNDM2MzRmM2U3NzBiMg=="
```