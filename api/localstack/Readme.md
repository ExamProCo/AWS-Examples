## Instal LocalStack CLI


```sh
docker network create localstack
brew install localstack/tap/localstack-cli
localstack start
```

```
aws s3 ls --endpoint-url https://0.0.0.0:4566
```

## Lets create some mock s3 buckets

```sh
aws s3 mb s3://amazon.com --endpoint-url http://0.0.0.0:4566
```

## Set an Env Var endpoint just for S3

export AWS_ENDPOINT_URL_S3="http://0.0.0.0:4566"