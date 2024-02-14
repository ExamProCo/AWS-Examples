#!/usr/bin/env bash

set -e

# Create our vpc

VPC_ID=$(aws ec2 create-vpc \
--cidr-block "172.1.0.0/16" \
--tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=my-vpc-3}]' \
--region ca-central-1  \
--query Vpc.VpcId \
--output text)

echo "VPC_ID: $VPC_ID"

# Turn on DNS Hostnames
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames "{\"Value\":true}"

# create an IGW
IGW_ID=$(aws ec2 create-internet-gateway \
--query InternetGateway.InternetGatewayId \
--output text
)

echo "IGW_ID: $IGW_ID"

# attach an IGW

aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID

# create a new subnet

SUBNET_ID=$(aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block 172.1.0.0/20 \
--query Subnet.SubnetId \
--output text)

echo "SUBNET_ID: $SUBNET_ID"

## auto assign IPv4 addresses

aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch

# explicty associate subnet

RT_ID=$(aws ec2 describe-route-tables \
--filters "Name=vpc-id,Values=$VPC_ID" "Name=association.main,Values=true" \
--query "RouteTables[].RouteTableId[]" \
--output text)

echo "RT_ID: $RT_ID"

ASSOC_ID=$(aws ec2 associate-route-table \
--route-table-id $RT_ID \
--subnet-id $SUBNET_ID \
--query AssociationId \
--output text)

echo "ASSOC_ID: $ASSOC_ID"

# add a route for our RT to our IGW

aws ec2 create-route \
--route-table-id $RT_ID \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id $IGW_ID

# Print out delete command
echo "./delete_vpc $VPC_ID $IGW_ID $SUBNET_ID $ASSOC_ID $RT_ID"