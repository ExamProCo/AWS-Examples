# Install Runtime for Rust Lambda

https://github.com/awslabs/aws-lambda-rust-runtime

brew tap cargo-lambda/cargo-lambda
brew install cargo-lambda

## Run
cargo lambda new example
cd example
cargo lambda build --release

## Deploy
cargo lambda deploy --iam-role arn:aws:iam::982383527471:role/RustLambdaAll

## Invoke

Install awscurl

```sh
pip install awscurl
```

Invoke
```sh
curl -v 'https://h4upffvrlo4vsifvw5axm7mm640nzpzj.lambda-url.ca-central-1.on.aws/?name=Andrew' \
-H 'content-type: application/json'
```