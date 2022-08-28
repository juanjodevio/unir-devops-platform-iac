provider "aws" {
  profile = "juanjodevio"
  region  = "us-east-1"
  version = "~> 2.0"
}

locals {
  unir-devops-medex-app = { version = "v0.7.4" }
}
# terraform {
#   backend "s3" {
#     bucket  = "terraform-backend-store"
#     encrypt = true
#     key     = "terraform.tfstate"
#     profile = "juanjodevio"
#     region  = "us-east-1"
#     # dynamodb_table = "terraform-state-lock-dynamo" - uncomment this line once the terraform-state-lock-dynamo has been terraformed
#   }
# }

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

module "vpc" {
  source             = "./modules/network"
  name               = var.name
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  environment        = var.environment
}

module "security_groups" {
  source         = "./modules/security-groups"
  name           = var.name
  vpc_id         = module.vpc.id
  environment    = var.environment
  container_port = var.container_port
}



# module "ecr" {
#   source      = "./modules/ecr"
#   name        = var.name
#   environment = var.environment
# }

