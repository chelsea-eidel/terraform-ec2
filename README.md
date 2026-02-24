# terraform-ec2

Tiny Terraform project to provision one EC2 instance (Amazon Linux 2023) in the default VPC.

## Prereqs
- Terraform installed
- AWS credentials configured (recommended: AWS CLI + `aws configure`)
- An existing EC2 Key Pair (optional, only needed for SSH)

## Quick start

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply