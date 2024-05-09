# S3 Bucket

aws s3 mb s3://glue-data-catalog-6163

# Download Data File

We can get data from here:

https://catalog.data.gov/dataset/electric-vehicle-population-data

```sh
curl https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD -o data/vehicle.csv
```

# Upload data to S3 bucket

```sh
aws s3 cp data/vehicle.csv s3://glue-data-catalog-6163/data/vehicle.csv
```

# AWS Glue Database

```sh
aws glue create-database --database-input Name=mydatabase
```

# Create Glue Crawler

```sh
aws glue create-crawler \
--name my-on-demand-crawler \
--role MyGlueServiceRole \
--database-name mydatabase \
--targets '{"S3Targets": [{"Path": "s3://mybucket/path/to/csv/"}]}' \
--table-prefix mycrawler_ \
--classifiers []
```