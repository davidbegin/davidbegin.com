#!/bin/bash

printf "\n\n\t\033[35;1mTerraform Apply\033[0m\n\n"

terraform get 

terraform apply                       \
  -var-file=tfvars/variables.tfvars   \
  -var-file=tfvars/packer_ami.tfvars \
  -auto-approve=false
