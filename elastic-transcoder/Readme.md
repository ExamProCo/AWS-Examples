## Create Content Buckets upload test video

```sh
aws s3 mb s3://srcvideos.example1254124.com --region us-east-1
aws s3 mb s3://videos.example1254124.com --region us-east-1
aws s3 cp App2Container.mp4 s3://srcvideos.example1254124.com/video.mp4 --region us-east-1
```



## Create Pipeline

```sh
aws elastictranscoder create-pipeline \
--name my-transcoder-pipeline \
--input-bucket srcvideos.example1254124.com \
--role arn:aws:iam::982383527471:role/Elastic_Transcoder_Default_Role \
--content-config file://content-config.json \
--thumbnail-config file://thumbnail-config.json \
--region us-east-1
```

## Create Job

```sh
aws elastictranscoder create-job \
--pipeline-id 1713880324699-qws2vn \
--inputs file://inputs.json \
--outputs file://outputs.json \
--output-key-prefix "videos/" \
--user-metadata file://user-metadata.json \
--region us-east-1 \
--query Job.Id
```

## Job Details

```sh
aws elastictranscoder read-job --id 1713880946080-cezshj --region us-east-1
```