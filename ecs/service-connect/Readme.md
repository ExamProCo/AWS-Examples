## Deploy Containers

```sh
aws ecs create-service --cli-input-json file://serv1.json
aws ecs create-service --cli-input-json file://serv2.json
```

## Connect to Container Env

```sh
aws ecs execute-command \
--cluster ecs-fargate-scECSCluster \
--task 33f675c3d6234eb98d1079cc1269e81e \
--container app \
--interactive \
--command "/bin/sh"
```

## Check Hosts

```sh
cat /etc/hosts
```

> If the first service is launched and then the second, it will not know about the first once. So connect to service 2

https://repost.aws/questions/QUczl6EqoRRemvw4b6KL_kDw/ecs-service-connect-could-not-resolve-host

## Test Public IP

curl 35.183.174.141:4567/api/hello?name=Andrew+Brown

## Test Service Connect Address 
curl http://app1.basic:4567/api/hello?name=Andrew+Brown