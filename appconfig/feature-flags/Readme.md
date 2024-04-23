## Install deps

```sh
bundle install
```

## Run web-app

```sh
rackup
```

## Test endpoint

```sh
curl localhost:9292/hello
```

## Create our bucket

```sh
aws s3 mb s3://my-appconfig-example-234324 --region us-east-1

## Create archive and upload to S3

```sh
zip -r app.zip app
aws s3 cp app.zip s3://my-appconfig-example-234324 --region us-east-1
```


## Test AppConfig Connection on Ec2 Instance


Ensure the agent is running

sudo aws configure set region us-east-1
sudo systemctl start aws-appconfig-agent
sudo systemctl status aws-appconfig-agent


Which ports are listening. We want to make sure 2772 is listening

```sh
sudo netstat -tulpn | grep LISTEN
```

curl "http://localhost:2772/applications/zcxkhf6/environments/jtsusj3/configurations/nviwmge"

## Debugging the Service

You may need to change the log levels

https://docs.aws.amazon.com/appconfig/latest/userguide/appconfig-integration-ec2.html

```sh
systemctl list-unit-files --all | grep aws
sudo journalctl -u aws-appconfig-agent.service
```

ls /etc/systemd/system/aws-appconfig-agent.service