# Chaining with Env Vars

```sh
export VPC_ID=$(
aws ec2 describe-vpcs \
--region us-east-1 \
--query Vpcs[0].VpcId \
--filters Name=is-default,Values=true \
--output text
)
```

```sh
export CIDR_BLOCK=$(aws ec2 describe-vpcs \
--region us-east-1 \
--query Vpcs[0].CidrBlock \
--filters Name=is-default,Values=true \
--output text | sed 's/0.0\/16/96.0\/20/')
```

```sh
echo $VPC_ID
echo $CIDR_BLOCK
```

aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block $CIDR_BLOCK \
--tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=my-ipv4-only-subnet}]' \
--region us-east-1


## Chaining with XArgs

aws ec2 describe-vpcs --query Vpcs[0].VpcId --region us-east-1 --output text --filters Name=is-default,Values=true | \
xargs -I {} aws ec2 describe-subnets --filters "Name=vpc-id,Values={}" --region us-east-1 --query "Subnets[*].[CidrBlock,SubnetId]" --output table


