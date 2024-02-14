## Create NACL

```sh
aws ec2 create-network-acl --vpc-id vpc-03181823a2da0addd
```

## Add entry

```sh
aws ec2 create-network-acl-entry \
--network-acl-id acl-02def3052778d5ce2 \
--ingress \
--rule-number 90 \
--protocol -1 \
--port-range From=0,To=65535 \
--cidr-block 174.5.108.3/32 \
--rule-action deny
```


## Get AMI for Amazon Linux 2

Gab the latest AML2 AMI
```sh
aws ec2 describe-images \
--owners amazon \
--filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" \
--query "Images[?starts_with(Name, 'amzn2')]|sort_by(@, &CreationDate)[-1].ImageId" \
--region ca-central-1 \
 --output text
```
