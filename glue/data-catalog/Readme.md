# S3 Bucket

aws s3 mb s3://glue-data-catalog-6163

# Download Data File

We can get data from here:

https://catalog.data.gov/dataset/electric-vehicle-population-data

```sh
curl https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD -o vehicle.csv
```

# Upload data to S3 bucket

```sh
aws s3 cp data/vehicle.csv s3://glue-data-catalog-6163/data/vehicle.csv
```

# AWS Glue Database

```sh
aws glue create-database --database-input Name=mydatabase
```

# Create IAM Role

```sh
aws iam create-role \
--role-name MyGlueServiceRole \
--assume-role-policy-document file://json/trust-policy.json
```

```sh
aws iam put-role-policy \
--role-name MyGlueServiceRole \
--policy-name MyS3AccessPolicy \
--policy-document file://json/policy.json
```

```sh
aws iam attach-role-policy \
--role-name MyGlueServiceRole \
--policy-arn arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole
```

# Create Glue Crawler

https://awscli.amazonaws.com/v2/documentation/api/latest/reference/glue/create-crawler.html

```sh
aws glue create-crawler \
--name MyCrawlerBasic \
--role MyGlueServiceRole \
--database-name mydatabase \
--targets '{"S3Targets": [{"Path": "s3://glue-data-catalog-6163/data/"}]}' \
--classifiers []
```
