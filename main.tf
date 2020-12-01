# Our main file where we can run all the modules for an easy spin up and spin down of the environment
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/VPC"

  cidr_block_target_vpc = var.cidr_block_target_vpc
  environment           = var.environment
  name                  = "simple-web-app"

  azs              = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  database_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }

  vpc_tags = {
    Name = "SimpleWebAppVPC"
  }
}

module "ECR" {
  source = "./modules/ECR"
}

module "EKS" {
  source = "./modules/EKS"

  cidr_block_target_vpc = var.cidr_block_target_vpc
  cluster_name          = var.cluster_name
  map_roles             = var.map_roles
  map_users             = var.map_users
  map_accounts          = var.map_accounts
  subnets               = module.vpc.private_subnets
  vpc_id                = module.vpc.vpc_id
  vpc_name              = module.vpc.name
}

module "KMS" {
  source = "./modules/KMS"

  application_name = var.application_name
  aws_account_id   = "723949785394"
  environment      = var.environment
}

module "RDS" {
  source = "./modules/RDS"

  cidr_block_target_vpc = var.cidr_block_target_vpc
  identifier            = var.identifier
  db_subnet_group_name  = module.vpc.name
  db_name               = var.db_name
  kms_key_id            = module.KMS.rds_kms_key_arn
  target_vpc_id         = module.vpc.vpc_id
}