variable "application_name" {
  description = "The application name"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account id"
  type        = number
}

variable "environment" {
  description = "The environment we will be deploying to, i.e sandbox,test,uat,prod"
  type        = string
}