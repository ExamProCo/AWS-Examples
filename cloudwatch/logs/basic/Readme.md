#create log

```sh
aws logs create-log-group --log-group-name "/example/basic/app"
```

#set retention policy

```sh
aws logs put-retention-policy --log-group-name "/example/basic/app" --retention-in-days 1
