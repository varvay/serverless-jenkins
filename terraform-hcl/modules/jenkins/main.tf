locals {
  tags = {
    "Product"     = var.product
    "Environment" = var.environment
  }
  launch_template_resource_tags = {
    instance          = local.tags
    volume            = local.tags
    network-interface = local.tags
  }
}

resource "aws_network_interface" "network_interface_master" {
  subnet_id       = var.subnet.id
  security_groups = [var.security_group.id]
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}-master"
  })
}

resource "aws_instance" "instance_master" {
  associate_public_ip_address = true
  ebs_optimized               = false
  hibernation                 = true
  ami                         = "ami-079db87dc4c10ac91"
  instance_type               = "t2.micro"
  key_name                    = "serverless-jenkins-dev-master"
  monitoring                  = false
  network_interface {
    delete_on_termination = true
    network_interface_id  = aws_network_interface.network_interface_master.id
    device_index          = 0
  }
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}-master"
  })
  volume_tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}-master"
  })
}