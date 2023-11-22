#!/usr/bin/env bash
aws s3api list-buckets | jq -r '.Buckets | sort_by(.CreationDate) | reverse | .[0] | .Name'