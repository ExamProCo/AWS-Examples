# Create Serverless Cache

aws elasticache create-serverless-cache \
--serverless-cache-name my-cache-ab-5252 \
 --major-engine-version 7

 # Install Redis Client (Ubuntu)

```sh
sudo apt-get install redis -y
```

# Connect to instance

```sh
redis-cli -h my-cache-ab-5252-ehplt6.serverless.cac1.cache.amazonaws.com
```