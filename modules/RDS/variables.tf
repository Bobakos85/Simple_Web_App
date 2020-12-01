# Optional Variables
variable "allocated_storage" {
  description = "This will provide the required allocated storage"
  type        = number
  default     = "30"
}

variable "availability_zones" {
  description = "AZs where the DB subnets will reside in"
  type        = list(string)
  default     = ["eu-west-2a","eu-west-2b","eu-west-2c"]
}
variable "backup_retention_days" {
  description = "Duration for which the backups will be retained"
  type        = number
  default     = "7"
}

variable "backup_window" {
  description = "Time window that the backup will be perfomed"
  type        = string
  default     = "04:00-07:00"
}

variable "db_cidr_range" {
  description = "CIDR Blocks where the DB subnets will reside in"
  type        = list(string)
  default     = ["10.0.10.0/24","10.0.11.0/24","10.0.12.0/24"]
}

variable "db_port" {
  description = "Port that the database will accessed over"
  type        = string
  default     = "5432"
}

variable "db_username" {
  description = "Admin username for the database"
  type        = string
  default     = "administrator"
}

variable "encrypted_enabled" {
  description = "Whether the database will be encrypted"
  type        = bool
  default     = true
}

variable "engine" {
  description = "The database engine we will be using"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The version of the database we will be using"
  type        = string
  default     = "11.5"
}

variable "environment" {
  description = "The environment we will be deploying to, i.e sandbox,test,uat,prod"
  type        = string
  default     = "sandbox"
}

variable "instance_class" {
  description = "Type of instnace to deploy"
  type        = string
  default     = "db.t3.micro"
}

variable "kms_key_id" {
  description = "the KMS key id we will be using for the RDS instance"
  type        = string
  default     = "arn:aws:kms:eu-west-2:723949785394:key/89083b9b-e191-4079-ba76-80f467b89af4"
}

variable "max_allocated_storage" {
  description = "Maximum size autoscaling storage we will be able to grow to"
  type        = number
  default     = "100"
}

variable "multi_az_enabled" {
  description = "Will the the RDs instance span multiple azs"
  type        = bool
  default     = false
}

variable "db_subnet_group_name"{
  description = "The Subnet Group Name that we want to use for the RDS"
  type        = string
  default     = "simple-web-app"
}

variable "tags" {
  description = "Default Tags to be used on all created resources"
  type = object(
    {
      application      = string
      automanage       = bool
      backup_retention = string
      backup_schedule  = string
      metadata         = string
      owner            = string
    }
  )
  default = {
    application      = "Simple Web App"
    automanage       = true
    backup_retention = "7 days"
    backup_schedule  = "04:00-07:00"
    metadata         = "N/A"
    owner            = "Thomas"
  }
}

# Mandatory Variables
variable "cidr_block_target_vpc" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "identifier" {
  description = "What will the RDS instance be called"
  type        = string
}

variable "route_table_id" {
  description = "The route table we will be associating the subnets with"
  type        = string
  default     = "rtb-037f8fdfeb80da2e6"
}

variable "target_vpc_id" {
  description = "The target VPC ID where the instances will be deployed to"
  type        = string
  default     = "vpc-06dd95958a89f7903"
} 