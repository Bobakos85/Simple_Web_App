resource "aws_ecr_repository" "ecr_repo" {
  name                 = "simplewebapp"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  
  tags = merge(
    {
      environment = var.environment
    },
    var.tags
  )
}