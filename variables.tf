variable "application_name" {
  description = "The application name"
  type        = string
  default     = "SimpleWebApp"
}

variable "aws_account_id" {
  description = "The AWS account id"
  type        = number
  default     = "723949785394"
}

variable "cidr_block_target_vpc" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "swa"
}

variable "environment" {
  description = "The environment we will be deploying to, i.e sandbox,test,uat,prod"
  type        = string
  default     = "sandbox"
}

variable "identifier" {
  description = "What will the RDS instance be called"
  type        = string
  default     = "swa"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::723949785394:user/tschizas"
      username = "tschizas"
      groups   = ["system:masters"]
    },
  ]
}

variable "region" {
  description = "Where we will be deploying to"
  default     = "eu-west-2"
}

# variable "route_table_id" {
#   description = "The route table we will be associating the subnets with"
#   type        = string
# }

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

variable "target_vpc_id" {
  description = "The target VPC ID where the instances will be deployed to"
  type        = string
  default     = ""
}

variable "vpc_tags" {
  type = object(
    { Name = string }
  )
  default = {
    Name = ""
  }
}