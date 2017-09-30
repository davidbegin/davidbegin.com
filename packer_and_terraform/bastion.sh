#!/usr/bin/env bash

bastion_ip=$(terraform output --json | jq -r ".bastion_public_ip.value")
echo "SSHing onto Bastion located at: $bastion_ip"
ssh -A "ubuntu@$bastion_ip"
