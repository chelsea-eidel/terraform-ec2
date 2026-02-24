# Use default VPC - grabs latest Amazon Linux 2023 AMI, creates a security group, launches instance

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Latest Amazon Linux 2023 AMI
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  description = "Security group for ${var.instance_name}"
  vpc_id      = data.aws_vpc.default.id

  # SSH (optional, but enabled here)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  # Example: allow HTTP if you want to serve something later
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default_vpc_subnets.ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Only set key_name if provided (empty string would error)
  key_name = var.key_pair_name != "" ? var.key_pair_name : null

  # Small bootstrap script (optional)
  user_data = <<-EOF
              #!/bin/bash
              set -euxo pipefail
              dnf -y update
              dnf -y install nginx
              systemctl enable --now nginx
              echo "Hello from Terraform on $(hostname)" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}
