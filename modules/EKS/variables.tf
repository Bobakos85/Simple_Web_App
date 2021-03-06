# Optional variables

variable "environment" {
  description = "The environment we will be deploying to, i.e sandbox,test,uat,prod"
  type        = string
  default     = "sandbox"
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
  type        = string
  default     = "eu-west-2"
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

# Mandatory variables

variable "cidr_block_target_vpc" {
  description = "The cidr block that the VPC will use"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "subnets" {
  description = "The subnets EKS will deploy its nodes on"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID for the the vpc we will be deploying to"
  type        = string
}

variable "vpc_name" {
  description = "The VPC Name for the the vpc we will be deploying to"
  type        = string
}