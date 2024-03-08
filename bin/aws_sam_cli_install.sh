#!/usr/bin/env bash
cd /workspace
curl -L "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -o "samcli.zip"
unzip samcli.zip -d sam-installation
sudo ./sam-installation/install
cd $THEIA_WORKSPACE_ROOT