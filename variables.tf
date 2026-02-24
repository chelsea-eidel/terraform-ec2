variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "ci-playground-ec2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ssh_cidr" {
  description = "CIDR allowed to SSH (lock this down; ideally your public IP /32)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_pair_name" {
  description = "Existing EC2 Key Pair name for SSH (leave empty to disable SSH key association)"
  type        = string
  default     = ""
}