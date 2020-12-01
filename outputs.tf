# ECR Output
output "repository_url" {
  description = "The ECR repo URL"
  value = module.ECR.repository_url
}

# EKS Outputs
output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.EKS.config_map_aws_auth
}

# RDS Outputs
output "db_instance_backend_endpoint" {
  value = module.RDS.db_instance_backend_endpoint
}

output "db_instance_backend_name" {
  value = module.RDS.db_instance_backend_name
}

output "db_instance_backend_port" {
  value = module.RDS.db_instance_backend_port
}

output "db_instance_backend_resource_id" {
  value = module.RDS.db_instance_backend_resource_id
}

output "db_instance_backend_sg_id" {
  value = module.RDS.db_instance_backend_sg_id
}

output "db_instance_backend_username" {
  value = module.RDS.db_instance_backend_username
}

output "db_instance_id" {
  value = module.RDS.db_instance_id
}

# KMS Outputs
output "rds_kms_key_arn" {
  description = "The RDS KMS Key arn"
  value = module.KMS.rds_kms_key_arn
}

output "rds_kms_key_id" {
  description = "The RDS KMS Key ID"
  value = module.KMS.rds_kms_key_id
}

# VPC Outputs

# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "name" {
  description = "The VPC name"
  value       = module.vpc.name
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# AZs
output "azs" {
  description = "List of availability zones"
  value       = module.vpc.azs
}

# DB Subnet Group ID
output "db_subnet_group_id" {
  description = "DB Subnet Group ID"
  value       = module.vpc.subnet_group_id
}