## Get the ECS EC2 Optimized AMI

https://docs.aws.amazon.com/AmazonECS/latest/developerguide/retrieve-ecs-optimized_AMI.html

```sh
aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2023/recommended --region ca-central-1
```

> Swap the region for your usecase

## Create Log Group

aws logs create-log-group --log-group-name ecs-ec2-basic

## Create our Task Def

aws ecs register-task-definition --cli-input-json file://task-def.json

## Deploy Container

aws ecs create-service --cli-input-json file://serv.json