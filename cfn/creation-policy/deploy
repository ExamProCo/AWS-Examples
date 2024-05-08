#!/usr/bin/env bash

STACK_NAME="creation-policy"

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/deploy/index.html
aws cloudformation deploy \
--template-file template.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--no-execute-changeset \
--region ca-central-1 \
--stack-name $STACK_NAME