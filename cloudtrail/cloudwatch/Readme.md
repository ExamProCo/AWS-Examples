# Create CloudWatch Log and Stream

aws logs create-log-group --log-group-name mycloudtrail

# Update trail for CloudWatch Logs
aws cloudtrail update-trail \
--name MyTrail \
--cloud-watch-logs-log-group-arn arn:aws:logs:ca-central-1:982383527471:log-group:mycloudtrail:* \
--cloud-watch-logs-role-arn arn:aws:iam::982383527471:role/MyCloudTrail2CloudWatchRole