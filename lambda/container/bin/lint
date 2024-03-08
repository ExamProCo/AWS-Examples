#!/usr/bin/env bash
set -e

# we need the absolute path because relative path was giving us trouble
root_path=$(realpath .)

# cfn-lint
# -------------------
# This will check our cloudformation template to ensure its valid format
echo "== CFN linting..."
cfn-lint "${root_path}/template.yml"