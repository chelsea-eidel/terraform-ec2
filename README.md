# terraform-ec2

Tiny Terraform project to provision one EC2 instance in AWS.

## What it creates

- EC2 instance (Amazon Linux 2023)
- Security group (HTTP + optional SSH)
- Dynamic AMI lookup
- Basic bootstrap using user_data (installs and starts nginx)

## Why this exists

This project demonstrates:

- Infrastructure as Code (IaC)
- Terraform provider configuration
- AWS credential chain usage
- Data sources (AMI + default VPC lookup)
- Security group configuration
- Output values and state management

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
```

## Expected Output

- Open in bowser once instance is live. 
- http://<public_ip>
- If everything worked you should see: "Hello from Terraform on <hostname>"

## Cleanup

- always run `terraform destroy` to terminate EC2, delete security group, leave no orphanced resources

## Key Takeaways

- Terraform uses declarative configuration and state management.
- AWS IAM permissions must explicitly allow required API actions.
- Data sources enable dynamic lookup of existing infrastructure.
- user_data allows automated instance bootstrapping.
