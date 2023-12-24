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

resource "aws_instance" "instance_master" {
  associate_public_ip_address = true
  ebs_optimized               = false
  hibernation                 = false
  ami                         = "ami-079db87dc4c10ac91"
  instance_type               = "t2.micro"
  key_name                    = "serverless-jenkins-dev-master"
  monitoring                  = false
  tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}-master"
  })
  volume_tags = merge(local.tags, {
    Name = "${var.product}-${var.environment}-master"
  })
  subnet_id = var.subnet.id
  security_groups = [ var.security_group.id ]
  user_data = filebase64("${path.module}/userData/jenkins-install.sh")
}