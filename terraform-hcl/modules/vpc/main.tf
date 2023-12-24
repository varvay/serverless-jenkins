locals {
  tags = {
    "Product"     = var.product
    "Environment" = var.environment
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/28"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}"
  })
}

resource "aws_subnet" "subnet" {
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}-us-east-1a"
  })
}

resource "aws_security_group" "security_group" {
  name_prefix = "${var.product}-${var.environment}-"
  vpc_id      = aws_vpc.vpc.id
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}"
  })
}

resource "aws_security_group_rule" "security_group_rule_ingress_allow_all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "security_group_rule_egress_allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}"
  })
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}-default"
  })
}

output "vpc" {
  value = aws_vpc.vpc
}

output "subnet" {
  value = aws_subnet.subnet
}

output "security_group" {
  value = aws_security_group.security_group
}