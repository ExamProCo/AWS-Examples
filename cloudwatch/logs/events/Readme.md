## Create Logging Data

```sh
python generate_json_logs.py > web_server_logs.json
```

# Filter Even Data

```sh
aws logs filter-log-events \
--log-group-name /example/events/json/app \
--filter-pattern '{ $.method = "PUT" }' \
--start-time 1717043643000 \
--end-time 1717076943000 \
--query events[].message \
--output text
```