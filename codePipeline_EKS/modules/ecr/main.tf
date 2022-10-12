resource "aws_ecr_repository" "registry" {

  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  tags     = var.tags

  image_scanning_configuration {
    scan_on_push = false
  }

}