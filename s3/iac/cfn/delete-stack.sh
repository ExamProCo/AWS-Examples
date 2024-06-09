#!/bin/bash

echo "== Delete S3 bucket via CloudFormation =="

STACK_NAME="cfn-s3-simple"
REGION="us-east-1"

# Delete CloudFormation stack
aws cloudformation delete-stack \
--region $REGION \
--stack-name $STACK_NAME

# Wait for the stack to be deleted
echo "Waiting for stack to be deleted..."
aws cloudformation wait stack-delete-complete \
--region $REGION \
--stack-name $STACK_NAME

echo "== Deletion complete =="
