
# Create bucket and upload file

```sh
aws s3 mb s3://rekog-example-1422 --region us-east-1
aws s3 cp andrew.jpg s3://rekog-example-1422
```

# Run ruby code

```sh
bundle install
bundle exec ruby main.rb
```