## Create Log Group

aws logs create-log-group --log-group-name ecs-ec2-fargate

## Create our Task Def

aws ecs register-task-definition --cli-input-json file://task-def.json

## Deploy Container

aws ecs create-service --cli-input-json file://serv.json