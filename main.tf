terraform {
  required_version = ">= 0.13.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.30.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ap_northeast"
}

module "vpc" {
  source       = "./modules/vpc"
  vpc_net_mask = var.vpc_net_mask
}

module "subnet" {
  source         = "./modules/subnet"
  vpc_net_mask   = var.vpc_net_mask
  vpc_id         = module.vpc.vpc_id
  route_table_id = module.vpc.route_table_id
}

module "sg" {
  source      = "./modules/security_group"
  name        = "isucon_sg"
  vpc_id      = module.vpc.vpc_id
  cidr_blocks = split(",", var.access_cidr_blocks)
}

module "participant-ec2" {
  source               = "./modules/ec2"
  standalone_ami_image_id = var.standalone_ami_image_id
  subnet_id            = module.subnet.subnet_id
  security_group_id    = module.sg.security_group_id
  ec2_members          = var.ec2_members
  ec2_instance_type    = var.ec2_instance_type
  ec2_volume_size      = var.ec2_volume_size
}
