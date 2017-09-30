#!/usr/bin/env bash

set -e

packer build \
  -var "aws_access_key=$AWS_ACCESS_KEY" \
  -var "aws_secret_key=$AWS_SECRET_KEY" \
  packer/templates/bastion.json | tee packer/logs/packer_output.txt

cat packer/logs/packer_output.txt | tail -n 2 \
  | sed '$ d' \
  | sed "s/us-west-1: /packer_built_bastion_ami = \"/" \
  | sed -e 's/[[:space:]]*$/\"/' > tfvars/packer_ami.tfvars

cat tfvars/packer_ami.tfvars
