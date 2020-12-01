variable "azs" {
  description = "The availability zones for the vpc"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "cidr_block_target_vpc" {
  description = "The cidr block that the VPC will use"
  type        = string
}

variable "database_subnets" {
  description = "The subnets for the database"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "environment" {
  description = "The environment we will be deploying to, i.e sandbox,test,uat,prod"
  type        = string
  default     = "sandbox"
}

variable "name" {
  description = "The name for the VPC"
  type = string
  default = "SimpleWebApp"
}

variable "private_subnets"{
  description = "The private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "public_subnets" {
  description = "The public subnets"
  type        = list(string)
  default     =["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
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
    backup_retention = "N/A"
    backup_schedule  = "N/A"
    metadata         = "N/A"
    owner            = "Thomas"
  }
}

variable "vpc_tags" {
  type = object(
    { Name = string }
  )
  default   = {
    Name = "SimpleWebApp"
  }
}