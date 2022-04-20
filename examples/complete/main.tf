terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.75.1"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc1" {
  source               = "git::ssh://git@github.com/inflearn/terraform-aws-vpc.git?ref=v3.14.0"
  name                 = "example-inflab-vpc-peering-1"
  cidr                 = "10.0.0.0/16"
  enable_dns_hostnames = true
  azs                  = ["ap-northeast-2a"]
  private_subnets      = []
  public_subnets       = ["10.0.0.0/24"]

  tags = {
    iac  = "terraform"
    temp = "true"
  }
}

module "vpc2" {
  source               = "git::ssh://git@github.com/inflearn/terraform-aws-vpc.git?ref=v3.14.0"
  name                 = "example-inflab-vpc-peering-2"
  cidr                 = "10.1.0.0/16"
  enable_dns_hostnames = true
  azs                  = ["ap-northeast-2a"]
  private_subnets      = []
  public_subnets       = ["10.1.0.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false

  tags = {
    iac  = "terraform"
    temp = "true"
  }
}

module "peering" {
  source                   = "../../"
  name                     = "example-inflab-vpc-peering"
  vpc_id                   = module.vpc1.vpc_id
  peer_vpc_id              = module.vpc2.vpc_id
  vpc_cidr_block           = module.vpc1.vpc_cidr_block
  peer_vpc_cidr_block      = module.vpc2.vpc_cidr_block
  vpc_allow_dns            = true
  peer_vpc_allow_dns       = true
  vpc_route_table_ids      = concat(module.vpc1.public_route_table_ids, module.vpc1.private_route_table_ids)
  peer_vpc_route_table_ids = concat(module.vpc2.public_route_table_ids, module.vpc2.private_route_table_ids)
  auto_accept              = true

  tags = {
    iac  = "terraform"
    temp = "true"
  }
}
