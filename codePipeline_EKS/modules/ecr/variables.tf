variable "ecr_repository_name" {
  description = "Name of the registery repository"
  type        = string
}


variable "tags" {
  description = "Tags to be applied to the codebuild project"
  type        = map(any)
}