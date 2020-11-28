variable "environment" {
  description = "The environment we will be deploying to, i.e sandbox,test,uat,prod"
  type        = string
  default     = "sandbox"
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