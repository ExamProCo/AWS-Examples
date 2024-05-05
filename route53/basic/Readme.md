# Change Record Set

aws route53 change-resource-record-sets \
--hosted-zone-id Z09877273W35UBRD4GPTY \
--region us-east-1 \
--change-batch '
{
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "www.cloudborg.org",
        "Type": "A",
        "TTL": 300,
        "ResourceRecords": [{ "Value": "50.17.101.87" }]
      }
    }
  ]
}'

# References

https://awscli.amazonaws.com/v2/documentation/api/latest/reference/route53/change-resource-record-sets.html#examples