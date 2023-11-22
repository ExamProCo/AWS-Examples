#!/usr/bin/env bash
echo "== list newest buckets"

aws s3api list-buckets | jq -r '.Buckets | sort_by(.CreationDate) | reverse | .[0:5] | .[] |  .Name'
echo "..."