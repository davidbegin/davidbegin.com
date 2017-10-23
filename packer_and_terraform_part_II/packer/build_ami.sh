#!/usr/bin/env bash

set -e

packer build \
  -var "aws_access_key=$AWS_ACCESS_KEY" \
  -var "aws_secret_key=$AWS_SECRET_KEY" \
  packer/templates/bastion.json
