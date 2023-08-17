#!/bin/bash
set -e # Exit on error

# Validate parameters (you might have environment parameters or others)
# if [ "$#" -ne 1 ]; then
#     echo "Usage: $0 <environment>"
#     exit 1
# fi

# ENVIRONMENT="$1"

# Terraform
cd terraform

# Initialize and apply Terraform changes
echo "### Initializing Terraform ###"
terraform init

# echo "### Applying Terraform ###" #for environment: $ENVIRONMENT ###"
# # terraform workspace select $ENVIRONMENT || terraform workspace new $ENVIRONMENT
# terraform apply -auto-approve

# Check if variables.local.tfvars exists and apply conditionally
if [ -f "variables.local.tfvars" ]; then
    echo "### Applying Terraform with local variables ###"
    terraform apply -auto-approve -var-file="variables.local.tfvars"
else
    echo "### Applying Terraform with default variables ###"
    terraform apply -auto-approve
fi

# Extract necessary data for Ansible if needed (e.g., IPs of resources)
# This assumes that your Terraform outputs some IP values that Ansible would use.
INSTANCE_IP=$(terraform output instance_ip)

cd ..

# Ansible
cd ansible

# Execute Ansible playbook
echo "### Running Ansible Playbook ###"
ansible-playbook -i "$INSTANCE_IP," playbooks/deploy.yml

cd ..

echo "### Deployment Complete ###"