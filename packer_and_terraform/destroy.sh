#!/usr/bin/env bash

printf "\n\n\t\033[35;1mTerraform Destroy\033[0m\n\n"

terraform get 

terraform destroy                     \
  -var-file=tfvars/variables.tfvars   \
  -var-file=tfvars/packer_ami.tfvars
