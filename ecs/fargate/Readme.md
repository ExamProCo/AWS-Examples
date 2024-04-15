## Create Log Group

aws logs create-log-group --log-group-name ecs-ec2-fargate

## Create our Task Def

aws ecs register-task-definition --cli-input-json file://task-def.json

## Deploy Container

aws ecs create-service --cli-input-json file://serv.json

# ECS Exec

## Installing SM CLI for AWS CLI on Ubunutu

https://docs.aws.amazon.com/systems-manager/latest/userguide/install-plugin-debian-and-ubuntu.html

```sh
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
```

## Connect to Container Env

```sh
aws ecs execute-command \
--cluster ecs-fargate-basicECSCluster \
--task 428da138d4d14ed0a1d825e7f17018f2 \
--container app \
--interactive \
--command "/bin/sh"
```