#!/usr/bin/env bash
set -e

# we need the absolute path of samconfig.toml
# because relative path was giving us trouble
root_path=$(realpath .)
template_path="${root_path}/template.yml"

# sam build
# ===================
# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-building.html
# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-build.html
# -------------------
# This will prepare the artifact to be uploaded to S3 by generating:
# .aws-sam/build/template.yml
echo "== SAM build..."
echo "using template: ${template_path}"
sam build \
  --template-file "${template_path}"