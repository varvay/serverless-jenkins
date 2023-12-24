terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }
}

locals {
  product     = "serverless-jenkins"
  environment = "dev"
  tags = {
    "Product"     = local.product
    "Environment" = local.environment
  }
}

provider "aws" {
  region     = var.aws_provider_configuration.region
  access_key = var.aws_provider_configuration.access_key
  secret_key = var.aws_provider_configuration.secret_key
  default_tags {
    tags = local.tags
  }
}

module "iam" {
  source      = "./modules/iam"
  environment = local.environment
  product     = local.product
}
