https://docs.aws.amazon.com/cli/latest/reference/cloudformation/set-stack-policy.html#examples

```sh
aws cloudformation set-stack-policy \
    --stack-name prevent-stack-update \
    --stack-policy-body '{"Statement" : [{
      "Effect" : "Deny",
      "Action" : "Update:*",
      "Principal": "*",
      "Resource" : "LogicalResourceId/MyEC2Instance"
    }]}'
```